import { promises as fs } from 'node:fs'
import path from 'node:path'

const rootDir = process.cwd()
const localFiammaBooksPath = path.join(rootDir, 'src', 'lib', 'localFiammaBooks.ts')
const defaultSiteUrl = 'https://fiammabooks.com'

async function pathExists(filePath) {
  try {
    await fs.access(filePath)
    return true
  } catch {
    return false
  }
}

async function loadVisibleBooks() {
  if (!(await pathExists(localFiammaBooksPath))) {
    throw new Error(`Missing local catalog source: ${localFiammaBooksPath}`)
  }

  const source = await fs.readFile(localFiammaBooksPath, 'utf8')
  const objects = source.split(/\}\s*,\s*\{/)
  const visibleBooks = []

  for (const block of objects) {
    const titleMatch = block.match(/title_id:\s*['"]([^'"]+)['"]/)
    const slugMatch = block.match(/slug:\s*['"]([^'"]+)['"]/)
    const visibleMatch = block.match(/visible:\s*(true|false)/)
    if (titleMatch && slugMatch && visibleMatch?.[1] === 'true') {
      visibleBooks.push({ title_id: titleMatch[1], slug: slugMatch[1] })
    }
  }

  return visibleBooks
}

function decodeJwtPayload(token) {
  return JSON.parse(Buffer.from(token.split('.')[1], 'base64url').toString('utf8'))
}

function findAnonKey(source) {
  const tokens = source.match(/eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+/g) ?? []
  return tokens.find((token) => {
    try {
      return decodeJwtPayload(token).role === 'anon'
    } catch {
      return false
    }
  })
}

async function loadConfigFromLiveBundle() {
  const siteUrl = (process.env.FIAMMA_SITE_URL ?? defaultSiteUrl).replace(/\/$/, '')
  const htmlResponse = await fetch(siteUrl)
  if (!htmlResponse.ok) {
    throw new Error(`Could not fetch ${siteUrl}: HTTP ${htmlResponse.status}`)
  }

  const html = await htmlResponse.text()
  const assetPaths = [
    ...new Set([...html.matchAll(/(?:src|href)=["']\/?(assets\/[^"']+\.js)["']/g)].map((match) => match[1])),
  ]

  for (const assetPath of assetPaths) {
    const assetUrl = `${siteUrl}/${assetPath}`
    const assetResponse = await fetch(assetUrl)
    if (!assetResponse.ok) continue

    const source = await assetResponse.text()
    const supabaseUrl = source.match(/https:\/\/[a-z0-9]+\.supabase\.co/)?.[0]
    const anonKey = findAnonKey(source)
    if (supabaseUrl && anonKey) return { supabaseUrl, anonKey, source: assetUrl }
  }

  throw new Error(`Could not resolve Supabase public config from ${siteUrl} bundle`)
}

async function resolveSupabaseConfig() {
  const supabaseUrl = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL
  const anonKey = process.env.VITE_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY
  if (supabaseUrl && anonKey) {
    return { supabaseUrl, anonKey, source: 'environment' }
  }
  return loadConfigFromLiveBundle()
}

function buildInFilter(values) {
  for (const value of values) {
    if (!/^[a-z0-9-]+$/.test(value)) {
      throw new Error(`Unexpected title_id format for PostgREST filter: ${value}`)
    }
  }
  return `in.(${values.join(',')})`
}

async function fetchLiveBooks(config, titleIds) {
  const url = new URL('/rest/v1/fiamma_books', config.supabaseUrl)
  url.searchParams.set('select', 'title_id,slug,visible')
  url.searchParams.set('title_id', buildInFilter(titleIds))

  const response = await fetch(url, {
    headers: {
      apikey: config.anonKey,
      Authorization: `Bearer ${config.anonKey}`,
    },
  })

  const text = await response.text()
  if (!response.ok) {
    throw new Error(`Supabase fiamma_books read failed: HTTP ${response.status} ${text.slice(0, 300)}`)
  }

  return JSON.parse(text)
}

async function main() {
  const visibleBooks = await loadVisibleBooks()
  if (visibleBooks.length === 0) {
    console.log('[reader-db-contract] No visible local Fiamma books found.')
    return
  }

  const config = await resolveSupabaseConfig()
  const liveBooks = await fetchLiveBooks(
    config,
    visibleBooks.map((book) => book.title_id),
  )
  const liveById = new Map(liveBooks.map((book) => [book.title_id, book]))

  const problems = []
  for (const localBook of visibleBooks) {
    const liveBook = liveById.get(localBook.title_id)
    if (!liveBook) {
      problems.push(
        `${localBook.title_id}: visible in localFiammaBooks.ts but missing from live public.fiamma_books; reader unlocks will fail with FK error 23503`,
      )
      continue
    }
    if (liveBook.slug !== localBook.slug) {
      problems.push(`${localBook.title_id}: live slug ${liveBook.slug} does not match local slug ${localBook.slug}`)
    }
    if (liveBook.visible !== true) {
      problems.push(`${localBook.title_id}: live fiamma_books row exists but visible is not true`)
    }
  }

  if (problems.length > 0) {
    for (const problem of problems) console.error(problem)
    process.exitCode = 1
    return
  }

  console.log(
    `[reader-db-contract] OK (${visibleBooks.length} visible local title(s) have matching live fiamma_books rows; config=${config.source})`,
  )
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})
