const defaultSiteUrl = 'https://fiammabooks.com'

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

async function fetchText(url) {
  const response = await fetch(url)
  if (!response.ok) {
    throw new Error(`GET ${url} failed: HTTP ${response.status}`)
  }
  return response.text()
}

async function loadPublicSupabaseConfig() {
  const siteUrl = (process.env.FIAMMA_SITE_URL ?? defaultSiteUrl).replace(/\/$/, '')
  const html = await fetchText(siteUrl)
  const assetPaths = [
    ...new Set([...html.matchAll(/(?:src|href)=["']\/?(assets\/[^"']+\.js)["']/g)].map((match) => match[1])),
  ]

  for (const assetPath of assetPaths) {
    const assetUrl = `${siteUrl}/${assetPath}`
    const source = await fetchText(assetUrl)
    const supabaseUrl = source.match(/https:\/\/[a-z0-9]+\.supabase\.co/)?.[0]
    const anonKey = findAnonKey(source)
    if (supabaseUrl && anonKey) return { supabaseUrl, anonKey, source: assetUrl }
  }

  throw new Error(`Could not find public Supabase config in ${siteUrl} assets`)
}

async function pingFiammaBooks({ supabaseUrl, anonKey, source }) {
  const url = new URL('/rest/v1/fiamma_books', supabaseUrl)
  url.searchParams.set('select', 'title_id')
  url.searchParams.set('visible', 'eq.true')
  url.searchParams.set('limit', '1')

  const response = await fetch(url, {
    headers: {
      apikey: anonKey,
      Authorization: `Bearer ${anonKey}`,
    },
  })
  const body = await response.text()

  if (!response.ok) {
    throw new Error(`Supabase keepalive failed: HTTP ${response.status} ${body.slice(0, 300)}`)
  }

  const rows = JSON.parse(body)
  if (!Array.isArray(rows)) {
    throw new Error('Supabase keepalive failed: response was not a JSON array')
  }

  console.log(`Supabase keepalive OK: read ${rows.length} row(s) from ${supabaseUrl} using config from ${source}`)
}

const config = await loadPublicSupabaseConfig()
await pingFiammaBooks(config)
