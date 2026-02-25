#!/usr/bin/env node
import { createClient } from '@supabase/supabase-js'
import { writeFileSync } from 'node:fs'
import { resolve as resolvePath } from 'node:path'

const NETLIFY_SITE_ID = process.env.NETLIFY_SITE_ID ?? 'eb9191bf-d05f-46e7-b9e3-1ea624d23e46'
const REPORT_PATH =
  process.env.REPORT_PATH ??
  resolvePath(
    process.cwd(),
    `qa_promise_integrity_report_${new Date().toISOString().slice(0, 10).replace(/-/g, '')}.md`,
  )

const requiredEnv = ['NETLIFY_AUTH_TOKEN', 'SUPABASE_ACCESS_TOKEN']
const missing = requiredEnv.filter((name) => !process.env[name])
if (missing.length > 0) {
  console.error(`Missing required env vars: ${missing.join(', ')}`)
  process.exit(1)
}

function nowIso() {
  return new Date().toISOString()
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms))
}

function redactEmail(email) {
  const [local, domain = ''] = String(email).split('@')
  const safeLocal = local.length <= 3 ? `${local[0] ?? ''}*` : `${local.slice(0, 2)}***${local.slice(-1)}`
  return `${safeLocal}@${domain}`
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

async function getNetlifyConfig() {
  const url = `https://api.netlify.com/api/v1/sites/${NETLIFY_SITE_ID}/env`
  const envList = await requestJson(url, {
    headers: {
      Authorization: `Bearer ${process.env.NETLIFY_AUTH_TOKEN}`,
    },
  })

  const byKey = new Map()
  for (const item of envList ?? []) {
    const contextAll = (item.values ?? []).find((entry) => entry.context === 'all')
    if (contextAll?.value) byKey.set(item.key, contextAll.value)
  }

  const config = {
    supabaseUrl: byKey.get('VITE_SUPABASE_URL'),
    supabaseAnonKey: byKey.get('VITE_SUPABASE_ANON_KEY'),
    mailerLiteApiKey: byKey.get('MAILERLITE_API_KEY'),
    mailerLiteGroupId: byKey.get('MAILERLITE_GROUP_ID'),
  }

  const required = Object.entries(config)
    .filter(([, value]) => !value)
    .map(([key]) => key)
  if (required.length > 0) {
    throw new Error(`Missing Netlify env values: ${required.join(', ')}`)
  }

  return config
}

async function getSupabaseServiceRole(projectRef) {
  const url = `https://api.supabase.com/v1/projects/${projectRef}/api-keys`
  const keys = await requestJson(url, {
    headers: {
      Authorization: `Bearer ${process.env.SUPABASE_ACCESS_TOKEN}`,
    },
  })
  const serviceRole = (keys ?? []).find((entry) => entry.name === 'service_role')
  if (!serviceRole?.api_key) {
    throw new Error('Could not find Supabase service_role API key')
  }
  return serviceRole.api_key
}

async function subscribeToMailerLite(email, mailerLiteApiKey, mailerLiteGroupId) {
  return requestJson('https://connect.mailerlite.com/api/subscribers', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${mailerLiteApiKey}`,
    },
    body: JSON.stringify({
      email,
      groups: [mailerLiteGroupId],
    }),
  })
}

function extractSubscriberEnvelope(payload) {
  if (!payload || typeof payload !== 'object') return null
  return payload.data && typeof payload.data === 'object' ? payload.data : payload
}

function extractSentCount(payload) {
  const envelope = extractSubscriberEnvelope(payload) ?? {}
  const directSent = Number(envelope.sent ?? NaN)
  if (!Number.isNaN(directSent)) return directSent
  const statsSent = Number(envelope.stats?.sent ?? NaN)
  if (!Number.isNaN(statsSent)) return statsSent
  return 0
}

function extractGroupIds(payload) {
  const envelope = extractSubscriberEnvelope(payload) ?? {}
  const groups = Array.isArray(envelope.groups) ? envelope.groups : []
  return groups.map((group) => String(group?.id ?? group)).filter(Boolean)
}

async function waitForMailerLiteSend(email, mailerLiteApiKey, expectedGroupId, timeoutMs = 150000, intervalMs = 5000) {
  const start = Date.now()
  let lastSeen = null

  while (Date.now() - start < timeoutMs) {
    const url = `https://connect.mailerlite.com/api/subscribers/${encodeURIComponent(email)}`
    const response = await fetch(url, {
      headers: {
        Authorization: `Bearer ${mailerLiteApiKey}`,
      },
    })

    if (response.status === 404) {
      await sleep(intervalMs)
      continue
    }

    const bodyText = await response.text()
    let body = null
    try {
      body = bodyText ? JSON.parse(bodyText) : null
    } catch {
      body = bodyText
    }

    if (!response.ok) {
      const snippet = typeof body === 'string' ? body.slice(0, 300) : JSON.stringify(body).slice(0, 300)
      throw new Error(`MailerLite lookup failed for ${email}: HTTP ${response.status} ${snippet}`)
    }

    const sent = extractSentCount(body)
    const groups = extractGroupIds(body)
    lastSeen = { sent, groups }

    if (sent >= 1 && groups.includes(String(expectedGroupId))) {
      return { ok: true, ...lastSeen }
    }

    await sleep(intervalMs)
  }

  return { ok: false, ...(lastSeen ?? { sent: 0, groups: [] }) }
}

async function deleteMailerLiteSubscriber(email, mailerLiteApiKey) {
  const url = `https://connect.mailerlite.com/api/subscribers/${encodeURIComponent(email)}`
  const response = await fetch(url, {
    method: 'DELETE',
    headers: {
      Authorization: `Bearer ${mailerLiteApiKey}`,
    },
  })
  if (response.status === 404) return
  if (!response.ok) {
    const body = await response.text().catch(() => '')
    throw new Error(`Failed deleting MailerLite subscriber ${email}: HTTP ${response.status} ${body.slice(0, 200)}`)
  }
}

async function collectBookIds(anonClient) {
  const { data, error } = await anonClient
    .from('fiamma_books')
    .select('title_id,slug,series_order,created_at')
    .eq('visible', true)
    .order('series_order', { ascending: true, nullsFirst: false })
    .order('created_at', { ascending: true })
    .limit(2)

  if (error) throw error
  const books = data ?? []
  if (books.length < 2) {
    throw new Error(`Need at least 2 visible books for promise gate, found ${books.length}`)
  }
  return books
}

async function claimUnlock(anonClient, bookId) {
  const { data, error } = await anonClient.rpc('fiamma_claim_gift_unlock', { p_book_id: bookId })
  if (error) throw error
  return data
}

async function runSingleAccount(testIndex, context) {
  const {
    anonClient,
    adminClient,
    books,
    noCreditsProbeBookId,
    mailerLiteApiKey,
    mailerLiteGroupId,
    runId,
    redirectBase,
  } = context
  const email = `qa_gate_${runId}_${testIndex}@example.net`
  const expectedStatuses = ['unlocked', 'already_unlocked', 'unlocked', 'no_credits']

  const result = {
    index: testIndex,
    email,
    redactedEmail: redactEmail(email),
    pass: false,
    notes: [],
    onboarding: { sent: 0, groups: [], ok: false },
    statuses: [],
    credits: null,
    unlockCount: 0,
    userId: null,
  }

  try {
    const { data: created, error: createError } = await adminClient.auth.admin.createUser({
      email,
      email_confirm: true,
      user_metadata: { qa_run: runId, qa_gate: 'promise_integrity' },
    })
    if (createError) throw createError
    if (!created?.user?.id) throw new Error('createUser did not return user id')
    result.userId = created.user.id
    result.notes.push('user_created')

    const redirectTo = `${redirectBase}/read/${books[0].slug}`
    const { error: sendError } = await anonClient.auth.signInWithOtp({
      email,
      options: {
        emailRedirectTo: redirectTo,
        shouldCreateUser: true,
        data: { fiamma_mode: 'magic_link', qa_run: runId },
      },
    })
    if (sendError) throw sendError
    result.notes.push('otp_send_requested')

    const { data: generated, error: linkError } = await adminClient.auth.admin.generateLink({
      type: 'magiclink',
      email,
      options: {
        redirectTo,
      },
    })
    if (linkError) throw linkError
    const otp = generated?.properties?.email_otp
    if (!otp) throw new Error('generateLink did not return email_otp')

    const { error: verifyError } = await anonClient.auth.verifyOtp({
      email,
      token: otp,
      type: 'email',
    })
    if (verifyError) throw verifyError
    result.notes.push('magic_link_verified')

    const { data: userData, error: userError } = await anonClient.auth.getUser()
    if (userError) throw userError
    if (!userData?.user?.id) throw new Error('No authenticated user after verifyOtp')
    result.userId = userData.user.id

    const { error: profileError } = await anonClient.from('fiamma_reader_profiles').upsert(
      [
        {
          user_id: result.userId,
          email,
          last_seen: nowIso(),
        },
      ],
      { onConflict: 'user_id', ignoreDuplicates: false },
    )
    if (profileError) throw profileError
    result.notes.push('profile_upserted')

    await subscribeToMailerLite(email, mailerLiteApiKey, mailerLiteGroupId)
    result.notes.push('mailerlite_subscribed')

    result.onboarding = await waitForMailerLiteSend(email, mailerLiteApiKey, mailerLiteGroupId)
    if (!result.onboarding.ok) {
      throw new Error(
        `Onboarding send not observed in MailerLite within timeout (sent=${result.onboarding.sent}, groups=${result.onboarding.groups.join('|')})`,
      )
    }
    result.notes.push('onboarding_send_observed')

    const claim1 = await claimUnlock(anonClient, books[0].title_id)
    const claim2 = await claimUnlock(anonClient, books[0].title_id)
    const claim3 = await claimUnlock(anonClient, books[1].title_id)
    const claim4 = await claimUnlock(anonClient, noCreditsProbeBookId)
    result.statuses = [claim1?.status, claim2?.status, claim3?.status, claim4?.status]

    const expectedStatusOk = result.statuses.every((status, idx) => status === expectedStatuses[idx])
    if (!expectedStatusOk) {
      throw new Error(`Unexpected claim status sequence: got=${JSON.stringify(result.statuses)} expected=${JSON.stringify(expectedStatuses)}`)
    }
    result.notes.push('unlock_status_sequence_ok')

    const { data: profileAfter, error: profileAfterError } = await anonClient
      .from('fiamma_reader_profiles')
      .select('gift_credits_remaining,gift_credits_total')
      .eq('user_id', result.userId)
      .maybeSingle()
    if (profileAfterError) throw profileAfterError
    result.credits = profileAfter ?? null

    const remaining = Number(profileAfter?.gift_credits_remaining ?? NaN)
    const total = Number(profileAfter?.gift_credits_total ?? NaN)
    if (remaining !== 0 || total !== 2) {
      throw new Error(`Unexpected credits after flow: remaining=${remaining}, total=${total}`)
    }
    result.notes.push('credit_balance_ok')

    const { data: unlockRows, error: unlockError } = await anonClient
      .from('fiamma_book_unlocks')
      .select('book_id')
      .eq('user_id', result.userId)
    if (unlockError) throw unlockError
    const uniqueUnlocks = new Set((unlockRows ?? []).map((row) => row.book_id))
    result.unlockCount = uniqueUnlocks.size
    if (result.unlockCount !== 2 || !uniqueUnlocks.has(books[0].title_id) || !uniqueUnlocks.has(books[1].title_id)) {
      throw new Error(`Unexpected unlock set: count=${result.unlockCount}`)
    }
    result.notes.push('unlock_set_ok')

    result.pass = true
    return result
  } catch (error) {
    result.notes.push(`error:${error instanceof Error ? error.message : String(error)}`)
    return result
  } finally {
    try {
      await anonClient.auth.signOut()
    } catch {}
    try {
      await deleteMailerLiteSubscriber(email, mailerLiteApiKey)
      result.notes.push('mailerlite_cleanup_ok')
    } catch (cleanupError) {
      result.notes.push(
        `mailerlite_cleanup_error:${cleanupError instanceof Error ? cleanupError.message : String(cleanupError)}`,
      )
    }
    if (result.userId) {
      try {
        await adminClient.auth.admin.deleteUser(result.userId)
        result.notes.push('auth_cleanup_ok')
      } catch (cleanupError) {
        result.notes.push(`auth_cleanup_error:${cleanupError instanceof Error ? cleanupError.message : String(cleanupError)}`)
      }
    }
  }
}

function buildReport({ startedAt, finishedAt, siteId, books, noCreditsProbeBookId, results, runId }) {
  const passed = results.filter((entry) => entry.pass).length
  const overall = passed === results.length ? 'PASS' : 'FAIL'
  const lines = [
    '# Fiamma Promise-Integrity QA Gate Report',
    '',
    `- run_id: \`${runId}\``,
    `- started_at_utc: \`${startedAt}\``,
    `- finished_at_utc: \`${finishedAt}\``,
    `- netlify_site_id: \`${siteId}\``,
    `- overall_result: **${overall}** (${passed}/${results.length} accounts passed)`,
    '',
    '## Book set used',
    '',
    ...books.map((book, idx) => `${idx + 1}. \`${book.title_id}\` (slug: \`${book.slug}\`)`),
    `${books.length + 1}. \`${noCreditsProbeBookId}\` (synthetic probe ID for no-credits assertion)`,
    '',
    '## Per-account results',
    '',
    '| account | email | onboarding_sent | statuses | credits | unlock_count | result |',
    '|---|---|---:|---|---|---:|---|',
    ...results.map((entry) => {
      const statuses = entry.statuses.length > 0 ? entry.statuses.join(' -> ') : 'n/a'
      const credits = entry.credits
        ? `${entry.credits.gift_credits_remaining}/${entry.credits.gift_credits_total}`
        : 'n/a'
      return `| ${entry.index} | ${entry.redactedEmail} | ${entry.onboarding.sent} | ${statuses} | ${credits} | ${entry.unlockCount} | ${entry.pass ? 'PASS' : 'FAIL'} |`
    }),
    '',
    '## Notes',
    '',
    ...results.map((entry) => `- account ${entry.index} (${entry.redactedEmail}): ${entry.notes.join(' | ')}`),
    '',
  ]
  return lines.join('\n')
}

async function main() {
  const startedAt = nowIso()
  const runId = `${Date.now()}`
  console.log(`[promise-gate] start run_id=${runId}`)

  const config = await getNetlifyConfig()
  const projectRef = new URL(config.supabaseUrl).hostname.split('.')[0]
  const serviceRoleKey = await getSupabaseServiceRole(projectRef)
  const redirectBase = process.env.READ_REDIRECT_BASE ?? 'https://fiammabooks.com'

  const adminClient = createClient(config.supabaseUrl, serviceRoleKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  })
  const anonClient = createClient(config.supabaseUrl, config.supabaseAnonKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  })

  const books = await collectBookIds(anonClient)
  const noCreditsProbeBookId = `qa-no-credits-probe-${runId}`
  console.log(`[promise-gate] using books: ${books.map((book) => book.title_id).join(', ')}`)

  const results = []
  for (let i = 1; i <= 5; i += 1) {
    console.log(`[promise-gate] account ${i}/5 start`)
    const result = await runSingleAccount(i, {
      anonClient,
      adminClient,
      books,
      noCreditsProbeBookId,
      mailerLiteApiKey: config.mailerLiteApiKey,
      mailerLiteGroupId: config.mailerLiteGroupId,
      runId,
      redirectBase,
    })
    results.push(result)
    console.log(`[promise-gate] account ${i}/5 ${result.pass ? 'PASS' : 'FAIL'} ${result.redactedEmail}`)
  }

  const finishedAt = nowIso()
  const report = buildReport({
    startedAt,
    finishedAt,
    siteId: NETLIFY_SITE_ID,
    books,
    noCreditsProbeBookId,
    results,
    runId,
  })

  writeFileSync(REPORT_PATH, report)
  const passed = results.filter((entry) => entry.pass).length
  console.log(`[promise-gate] completed ${passed}/${results.length} passed`)
  console.log(`[promise-gate] report=${REPORT_PATH}`)

  if (passed !== results.length) {
    process.exitCode = 1
  }
}

main().catch((error) => {
  console.error(`[promise-gate] fatal: ${error instanceof Error ? error.message : String(error)}`)
  process.exit(1)
})
