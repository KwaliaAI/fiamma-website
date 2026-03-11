#!/usr/bin/env node
import { createClient } from '@supabase/supabase-js'

const DEFAULT_SUPABASE_URL = 'https://mpohvxobtbuuxzhxrbpy.supabase.co'

function parseArgs(argv) {
  const options = {
    window: 'yesterday',
    since: null,
    json: false,
  }

  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index]
    if (arg === '--json') {
      options.json = true
      continue
    }
    if (arg === '--window') {
      options.window = argv[index + 1] ?? options.window
      index += 1
      continue
    }
    if (arg === '--since') {
      options.since = argv[index + 1] ?? null
      index += 1
    }
  }

  return options
}

function resolveWindowStart(options) {
  if (options.since) {
    const explicit = new Date(`${options.since}T00:00:00Z`)
    if (Number.isNaN(explicit.getTime())) {
      throw new Error(`Invalid --since value: ${options.since}`)
    }
    return explicit
  }

  const now = new Date()
  const startTodayUtc = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate()))
  if (options.window === 'today') return startTodayUtc
  if (options.window === 'last24h') return new Date(now.getTime() - 24 * 60 * 60 * 1000)
  if (options.window === 'yesterday') return new Date(startTodayUtc.getTime() - 24 * 60 * 60 * 1000)
  throw new Error(`Unsupported --window value: ${options.window}`)
}

function getSupabaseConfig() {
  const supabaseUrl = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL || DEFAULT_SUPABASE_URL
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  const projectRef = new URL(supabaseUrl).hostname.split('.')[0]
  return { supabaseUrl, serviceRoleKey, projectRef }
}

async function requestJson(url, options = {}) {
  const response = await fetch(url, options)
  const text = await response.text()
  let body = null
  try {
    body = text ? JSON.parse(text) : null
  } catch {
    body = text
  }

  if (!response.ok) {
    const snippet = typeof body === 'string' ? body.slice(0, 300) : JSON.stringify(body).slice(0, 300)
    throw new Error(`HTTP ${response.status} for ${url}: ${snippet}`)
  }
  return body
}

async function getServiceRoleKey(projectRef, existingKey) {
  if (existingKey) return existingKey

  const accessToken = process.env.SUPABASE_ACCESS_TOKEN
  if (!accessToken) {
    throw new Error('Missing SUPABASE_ACCESS_TOKEN (or SUPABASE_SERVICE_ROLE_KEY).')
  }

  const keys = await requestJson(`https://api.supabase.com/v1/projects/${projectRef}/api-keys`, {
    headers: {
      Authorization: `Bearer ${accessToken}`,
    },
  })

  const serviceRole = (keys ?? []).find((entry) => entry.name === 'service_role')
  if (!serviceRole?.api_key) {
    throw new Error('Could not resolve Supabase service_role API key.')
  }
  return serviceRole.api_key
}

function isExternalEmail(email) {
  const value = String(email || '').trim().toLowerCase()
  if (!value) return false
  if (value.endsWith('@kwalia.ai')) return false
  if (value.endsWith('@example.com')) return false
  return true
}

function sortByDateDesc(rows, key) {
  return [...rows].sort((left, right) => new Date(right[key]).getTime() - new Date(left[key]).getTime())
}

async function loadFunnelSnapshot(supabase, sinceIso) {
  const { data: recentProfiles, error: profilesError } = await supabase
    .from('fiamma_reader_profiles')
    .select('user_id,email,created_at,last_seen,source')
    .gte('created_at', sinceIso)
    .order('created_at', { ascending: false })

  if (profilesError) throw profilesError

  const { data: recentProgress, error: progressError } = await supabase
    .from('fiamma_reading_progress')
    .select('user_id,book_id,last_chapter,completed,updated_at')
    .gte('updated_at', sinceIso)
    .order('updated_at', { ascending: false })

  if (progressError) throw progressError

  const allUserIds = [...new Set((recentProgress ?? []).map((row) => row.user_id).filter(Boolean))]
  const allBookIds = [...new Set((recentProgress ?? []).map((row) => row.book_id).filter(Boolean))]

  const profilesByUserId = new Map((recentProfiles ?? []).map((row) => [row.user_id, row]))
  if (allUserIds.length > 0) {
    const missingUserIds = allUserIds.filter((userId) => !profilesByUserId.has(userId))
    if (missingUserIds.length > 0) {
      const { data: extraProfiles, error: extraProfilesError } = await supabase
        .from('fiamma_reader_profiles')
        .select('user_id,email,created_at,last_seen,source')
        .in('user_id', missingUserIds)

      if (extraProfilesError) throw extraProfilesError
      for (const row of extraProfiles ?? []) profilesByUserId.set(row.user_id, row)
    }
  }

  const booksById = new Map()
  if (allBookIds.length > 0) {
    const { data: books, error: booksError } = await supabase
      .from('fiamma_books')
      .select('title_id,title,slug')
      .in('title_id', allBookIds)

    if (booksError) throw booksError
    for (const row of books ?? []) booksById.set(row.title_id, row)
  }

  const externalProfiles = sortByDateDesc((recentProfiles ?? []).filter((row) => isExternalEmail(row.email)), 'created_at')
  const externalProgress = sortByDateDesc(
    (recentProgress ?? [])
      .map((row) => {
        const profile = profilesByUserId.get(row.user_id)
        const book = booksById.get(row.book_id)
        return {
          email: profile?.email ?? null,
          created_at: profile?.created_at ?? null,
          source: profile?.source ?? null,
          title: book?.title ?? row.book_id,
          slug: book?.slug ?? row.book_id,
          last_chapter: row.last_chapter,
          completed: row.completed,
          updated_at: row.updated_at,
        }
      })
      .filter((row) => isExternalEmail(row.email)),
    'updated_at',
  )

  const externalProgressByUser = new Map()
  for (const row of externalProgress) {
    const existing = externalProgressByUser.get(row.email)
    if (!existing) externalProgressByUser.set(row.email, [])
    externalProgressByUser.get(row.email).push(row)
  }

  const newReadersWhoStarted = externalProfiles.filter((profile) => externalProgressByUser.has(profile.email))

  return {
    external_signups: externalProfiles,
    external_reading_activity: externalProgress,
    external_new_readers_who_started: newReadersWhoStarted.map((profile) => ({
      email: profile.email,
      created_at: profile.created_at,
      books: (externalProgressByUser.get(profile.email) ?? []).map((row) => ({
        title: row.title,
        slug: row.slug,
        last_chapter: row.last_chapter,
        completed: row.completed,
        updated_at: row.updated_at,
      })),
    })),
  }
}

function formatTextReport(report) {
  const lines = [
    `Window start: ${report.window_start}`,
    `External new sign-ins: ${report.external_signups.length}`,
    `External readers with reading activity: ${new Set(report.external_reading_activity.map((row) => row.email)).size}`,
    `New external readers who started reading: ${report.external_new_readers_who_started.length}`,
    '',
    'New external sign-ins:',
  ]

  if (report.external_signups.length === 0) {
    lines.push('- none')
  } else {
    for (const row of report.external_signups) {
      lines.push(`- ${row.email} | created ${row.created_at}`)
    }
  }

  lines.push('', 'External reading activity:')
  if (report.external_reading_activity.length === 0) {
    lines.push('- none')
  } else {
    for (const row of report.external_reading_activity) {
      lines.push(
        `- ${row.email} | ${row.title} | chapter ${row.last_chapter} | completed=${row.completed} | updated ${row.updated_at}`,
      )
    }
  }

  return lines.join('\n')
}

async function main() {
  const options = parseArgs(process.argv.slice(2))
  const windowStart = resolveWindowStart(options)
  const windowStartIso = windowStart.toISOString()
  const { supabaseUrl, serviceRoleKey, projectRef } = getSupabaseConfig()
  const resolvedServiceRoleKey = await getServiceRoleKey(projectRef, serviceRoleKey)

  const supabase = createClient(supabaseUrl, resolvedServiceRoleKey, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
    },
  })

  const snapshot = await loadFunnelSnapshot(supabase, windowStartIso)
  const report = {
    window_start: windowStartIso,
    ...snapshot,
  }

  if (options.json) {
    console.log(JSON.stringify(report, null, 2))
    return
  }

  console.log(formatTextReport(report))
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : String(error))
  process.exit(1)
})
