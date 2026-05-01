#!/usr/bin/env node
// Backfill MailerLite list from Supabase reader tables.
//
// Why this exists: the production MAILERLITE_API_KEY has been issued without
// scopes since at least 2026-02-22. Every reader signup since the site went
// live was captured in Supabase (fiamma_reader_intakes + fiamma_reader_profiles)
// but never reached MailerLite. The audit
// /home/oss/_agents/shared/exchange/report_subagent_fiamma-reader-funnel-audit_2026-05-01.md
// caught this 2026-05-01.
//
// Run after the API token is reissued with subscriber-write scopes:
//   MAILERLITE_API_KEY=<new-jwt> \
//   MAILERLITE_GROUP_ID=<group-id> \
//   SUPABASE_URL=<https://...supabase.co> \
//   SUPABASE_SERVICE_ROLE_KEY=<srk> \
//     node scripts/mailerlite_backfill_from_supabase.mjs [--dry-run]
//
// Idempotent. MailerLite returns 200 for an existing subscriber as well as for
// new creations, so safe to re-run.

const DRY_RUN = process.argv.includes('--dry-run')

const requiredEnv = ['MAILERLITE_API_KEY', 'MAILERLITE_GROUP_ID', 'SUPABASE_URL', 'SUPABASE_SERVICE_ROLE_KEY']
for (const key of requiredEnv) {
  if (!process.env[key]) {
    console.error(`Missing required env: ${key}`)
    process.exit(2)
  }
}

const apiKey = process.env.MAILERLITE_API_KEY
const groupId = process.env.MAILERLITE_GROUP_ID
const supabaseUrl = process.env.SUPABASE_URL.replace(/\/$/, '')
const srk = process.env.SUPABASE_SERVICE_ROLE_KEY

// Internal accounts to exclude from backfill — the readership-reality memory at
// memory/project_fiamma_readership_reality_2026-05-01.md tracks these.
const INTERNAL_DOMAINS = new Set(['kwalia.ai', 'example.com'])
const INTERNAL_EMAILS = new Set([
  '0@kwalia.ai',
  'javierdpm@gmail.com',
  'rado.molina@gmail.com',
])

function isInternal(email) {
  const lower = email.trim().toLowerCase()
  if (INTERNAL_EMAILS.has(lower)) return true
  if (lower.startsWith('qa_debug_')) return true
  const at = lower.lastIndexOf('@')
  if (at === -1) return true
  const domain = lower.slice(at + 1)
  return INTERNAL_DOMAINS.has(domain)
}

async function fetchEmails(table, column = 'email') {
  const url = `${supabaseUrl}/rest/v1/${table}?select=${column},created_at&order=created_at.asc`
  const res = await fetch(url, {
    headers: {
      apikey: srk,
      Authorization: `Bearer ${srk}`,
    },
  })
  if (!res.ok) {
    throw new Error(`Supabase ${table} read failed: ${res.status} ${await res.text()}`)
  }
  return res.json()
}

async function subscribeOne(email) {
  if (DRY_RUN) {
    return { ok: true, dryRun: true, email }
  }
  const res = await fetch('https://connect.mailerlite.com/api/subscribers', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${apiKey}`,
    },
    body: JSON.stringify({ email, groups: [groupId] }),
  })
  const body = await res.text().catch(() => '')
  return {
    ok: res.ok,
    status: res.status,
    email,
    body: body.slice(0, 400),
  }
}

async function main() {
  console.log(`MailerLite backfill — ${DRY_RUN ? 'DRY RUN' : 'LIVE'}`)

  const [profiles, intakes] = await Promise.all([
    fetchEmails('fiamma_reader_profiles'),
    fetchEmails('fiamma_reader_intakes'),
  ])

  const seen = new Set()
  const queue = []
  for (const row of [...profiles, ...intakes]) {
    const email = (row.email || '').trim().toLowerCase()
    if (!email || seen.has(email)) continue
    seen.add(email)
    if (isInternal(email)) {
      console.log(`SKIP internal: ${email}`)
      continue
    }
    queue.push({ email, source_created: row.created_at })
  }

  console.log(`\n${queue.length} external email(s) to push.`)
  if (queue.length === 0) {
    console.log('Nothing to backfill. Exiting clean.')
    return
  }

  const results = { ok: 0, failed: 0, errors: [] }
  for (const { email, source_created } of queue) {
    const r = await subscribeOne(email)
    if (r.ok) {
      results.ok += 1
      console.log(`OK ${email} (created in Supabase ${source_created})`)
    } else {
      results.failed += 1
      results.errors.push(r)
      console.error(`FAIL ${email} status=${r.status} body=${r.body}`)
    }
  }

  console.log(`\nDone. ok=${results.ok} failed=${results.failed}`)
  if (results.failed > 0) {
    process.exitCode = 1
  }
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})
