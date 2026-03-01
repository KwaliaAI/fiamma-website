#!/usr/bin/env node

import { readFileSync } from 'node:fs'
import { resolve as resolvePath } from 'node:path'

const NETLIFY_SITE_ID = process.env.NETLIFY_SITE_ID ?? 'eb9191bf-d05f-46e7-b9e3-1ea624d23e46'
const AUTOMATION_NAME =
  process.env.MAILERLITE_AUTOMATION_NAME ?? 'Fiamma | Welcome + First Read Activation'
const TEMPLATE_PATH =
  process.env.FIAMMA_EMAIL_TEMPLATE_PATH ??
  '/home/oss/_agents/shared/fiamma_narrative_engine/governance/email_template_v1.html'
const SENDER_NAME = process.env.FIAMMA_SENDER_NAME ?? 'Aubrey Kenneth-Moss'
const SENDER_EMAIL = process.env.FIAMMA_SENDER_EMAIL ?? 'hello@fiammabooks.com'
const REPLY_TO = process.env.FIAMMA_REPLY_TO ?? 'hello@fiammabooks.com'
const LINK_BASE_URL = process.env.FIAMMA_LINK_BASE_URL ?? 'https://fiammabooks.com'
const DRY_RUN = process.argv.includes('--dry-run')

const FLOW_SPEC = {
  A1: {
    subject: 'Welcome to the disaster zone.',
    paragraphs: [
      'I am so glad you made it.',
      'I write about people who could run a Fortune 500 company but can not parallel park to save their lives. It is my favorite kind of chaos to create.',
      'You are officially unlocked. I have also included access to my other new release, so you have options depending on your mood. One is a slow legal burn; the other is a beautiful catastrophe.',
      'Pick whichever matches your mood and enjoy the ride. I would love to hear which one you decided to start with.',
    ],
    buttons: [
      { label: 'READ TERMS & CONDITIONS', href: `${LINK_BASE_URL}/read/akm-001` },
      { label: 'READ FIELD STUDY', href: `${LINK_BASE_URL}/read/akm-002` },
    ],
  },
  A2: {
    subject: 'Checking in on your heart rate.',
    paragraphs: [
      'How are we doing?',
      'I know how it goes. You sit down for five minutes, and suddenly you are fifty pages in and wondering where the time went.',
      'If you are currently ignoring your responsibilities to find out what happens next, I apologize. But also, you are welcome.',
      'Go finish what you started.',
      'If you have thoughts, or complaints, or just want to tell me I am wrong for making them wait that long, I am here. Let\'s gossip.',
    ],
    buttons: [{ label: 'CONTINUE READING', href: `${LINK_BASE_URL}/catalog` }],
  },
  A3: {
    subject: 'More stories for your 3 AM habit.',
    paragraphs: [
      'I am so happy you gave my work a try.',
      'If you have finished both and you are looking for that next specific rush, there is plenty more where that came from. I have a whole library of characters who are just as brilliant and just as messy as the ones you just met.',
      'Come see what else I have been burning through lately.',
      'Tell me what you are in the mood for next. I would love to give you a recommendation.',
    ],
    buttons: [{ label: 'SEE MORE FROM AUBREY', href: `${LINK_BASE_URL}/catalog` }],
  },
}

function escapeHtml(text) {
  return String(text)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')
}

function renderContentBody(spec) {
  const paragraphHtml = spec.paragraphs.map((line) => `<p>${escapeHtml(line)}</p>`).join('\n')
  const buttonHtml = spec.buttons
    .map(
      (button) =>
        `<a class="btn" href="${escapeHtml(button.href)}" target="_blank" rel="noopener noreferrer">${escapeHtml(button.label)}</a>`,
    )
    .join('\n')

  return `${paragraphHtml}\n${buttonHtml}`
}

function renderHtmlEmail(baseTemplate, spec) {
  const preparedTemplate = baseTemplate
    .replace(/\{\{unsubscribe_url\}\}/g, '{$unsubscribe}')
    .replace(/\{\{web_view_url\}\}/g, '{$url}')

  return preparedTemplate
    .replace(/\{\{subject\}\}/g, escapeHtml(spec.subject))
    .replace(/\{\{content\}\}/g, renderContentBody(spec))
}

function renderPlainText(spec) {
  const lines = []
  lines.push(spec.subject)
  lines.push('')
  for (const p of spec.paragraphs) {
    lines.push(p)
    lines.push('')
  }
  for (const b of spec.buttons) {
    lines.push(`${b.label}: ${b.href}`)
  }
  lines.push('')
  lines.push('-- Aubrey K.M.')
  lines.push('')
  lines.push('View in browser: {$url}')
  lines.push('Unsubscribe: {$unsubscribe}')
  return lines.join('\n')
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
    const snippet = typeof body === 'string' ? body.slice(0, 400) : JSON.stringify(body).slice(0, 400)
    throw new Error(`HTTP ${response.status} for ${url}: ${snippet}`)
  }
  return body
}

async function getMailerLiteConfig() {
  const token = process.env.NETLIFY_AUTH_TOKEN
  if (!token) throw new Error('Missing NETLIFY_AUTH_TOKEN')

  const envList = await requestJson(`https://api.netlify.com/api/v1/sites/${NETLIFY_SITE_ID}/env`, {
    headers: { Authorization: `Bearer ${token}` },
  })

  const byKey = new Map()
  for (const item of envList ?? []) {
    const allValue = (item.values ?? []).find((entry) => entry.context === 'all')?.value
    if (allValue) byKey.set(item.key, allValue)
  }

  const apiKey = byKey.get('MAILERLITE_API_KEY')
  const groupId = byKey.get('MAILERLITE_GROUP_ID')
  if (!apiKey || !groupId) {
    throw new Error('Missing MAILERLITE_API_KEY or MAILERLITE_GROUP_ID in Netlify env')
  }

  return { apiKey, groupId }
}

async function getAutomationByName(apiKey) {
  const response = await requestJson('https://connect.mailerlite.com/api/automations?limit=100', {
    headers: { Authorization: `Bearer ${apiKey}` },
  })
  const automation = (response.data ?? []).find((item) => item.name === AUTOMATION_NAME)
  if (!automation?.id) throw new Error(`Automation not found: ${AUTOMATION_NAME}`)
  return automation
}

async function getAutomationDetail(apiKey, automationId) {
  return requestJson(`https://connect.mailerlite.com/api/automations/${automationId}`, {
    headers: { Authorization: `Bearer ${apiKey}` },
  })
}

function pickEmailSteps(automationDetail) {
  const emailSteps = (automationDetail.data?.steps ?? []).filter((step) => step.type === 'email')
  const a1 = emailSteps.find((step) => /^A1\b/i.test(step.name ?? ''))
  const a2 = emailSteps.filter((step) => /^A2\b/i.test(step.name ?? ''))
  const a3 = emailSteps.filter((step) => /^A3\b/i.test(step.name ?? ''))

  if (!a1?.email_id) throw new Error('Could not find A1 email step')
  if (a2.length < 1 || a2.some((step) => !step.email_id)) throw new Error('Could not find A2 email step(s)')
  if (a3.length < 1 || a3.some((step) => !step.email_id)) throw new Error('Could not find A3 email step(s)')

  return {
    A1: [a1],
    A2: a2,
    A3: a3,
  }
}

async function updateAutomationEmail(apiKey, automationId, emailStep, spec, htmlBody) {
  const payload = {
    from: SENDER_EMAIL,
    from_name: SENDER_NAME,
    reply_to: REPLY_TO,
    subject: spec.subject,
    content: htmlBody,
    plain_text: renderPlainText(spec),
  }

  const url = `https://connect.mailerlite.com/api/automations/${automationId}/emails/${emailStep.email_id}`

  if (DRY_RUN) {
    return {
      dry_run: true,
      email_id: emailStep.email_id,
      name: emailStep.name,
      subject: payload.subject,
      from_name: payload.from_name,
      reply_to: payload.reply_to,
    }
  }

  const result = await requestJson(url, {
    method: 'PUT',
    headers: {
      Authorization: `Bearer ${apiKey}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload),
  })

  return {
    dry_run: false,
    email_id: result.data?.id ?? emailStep.email_id,
    step_id: emailStep.id,
    name: result.data?.name ?? emailStep.name,
    subject: result.data?.subject ?? payload.subject,
    from_name: result.data?.from_name ?? payload.from_name,
    reply_to: result.data?.reply_to ?? payload.reply_to,
  }
}

async function updateAutomationStep(apiKey, automationId, emailStep, spec) {
  const payload = {
    data: {
      name: emailStep.name,
      subject: spec.subject,
      from: SENDER_EMAIL,
      from_name: SENDER_NAME,
      reply_to: REPLY_TO,
      email_id: emailStep.email_id,
    },
  }

  const url = `https://connect.mailerlite.com/api/automations/${automationId}/steps/${emailStep.id}`

  if (DRY_RUN) {
    return {
      dry_run: true,
      step_id: emailStep.id,
      email_id: emailStep.email_id,
      name: emailStep.name,
      subject: payload.data.subject,
      from_name: payload.data.from_name,
      reply_to: payload.data.reply_to,
    }
  }

  const result = await requestJson(url, {
    method: 'PUT',
    headers: {
      Authorization: `Bearer ${apiKey}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload),
  })

  return {
    dry_run: false,
    step_id: result.data?.id ?? emailStep.id,
    email_id: result.data?.email_id ?? result.data?.email?.id ?? emailStep.email_id,
    name: result.data?.name ?? emailStep.name,
    subject: result.data?.subject ?? payload.data.subject,
    from_name: result.data?.from_name ?? payload.data.from_name,
    reply_to: result.data?.reply_to ?? payload.data.reply_to,
  }
}

async function verifyLink(url) {
  try {
    let response = await fetch(url, { method: 'HEAD', redirect: 'follow' })
    if (response.status === 405 || response.status === 501) {
      response = await fetch(url, { method: 'GET', redirect: 'follow' })
    }
    return {
      url,
      status: response.status,
      ok: response.status >= 200 && response.status < 400,
      final_url: response.url,
    }
  } catch (error) {
    return { url, ok: false, error: error instanceof Error ? error.message : String(error) }
  }
}

async function main() {
  const template = readFileSync(resolvePath(TEMPLATE_PATH), 'utf8')
  const { apiKey, groupId } = await getMailerLiteConfig()
  const automation = await getAutomationByName(apiKey)
  const detail = await getAutomationDetail(apiKey, automation.id)
  const stepGroups = pickEmailSteps(detail)

  const updates = []
  for (const [key, steps] of Object.entries(stepGroups)) {
    const spec = FLOW_SPEC[key]
    const html = renderHtmlEmail(template, spec)
    for (const step of steps) {
      const stepResult = await updateAutomationStep(apiKey, automation.id, step, spec)
      const currentEmailStep = {
        ...step,
        email_id: stepResult.email_id ?? step.email_id,
      }
      const emailResult = await updateAutomationEmail(apiKey, automation.id, currentEmailStep, spec, html)
      updates.push({
        step: stepResult,
        email: emailResult,
      })
    }
  }

  const refreshed = await getAutomationDetail(apiKey, automation.id)
  const refreshedEmails = (refreshed.data?.steps ?? [])
    .filter((step) => step.type === 'email')
    .map((step) => ({
      name: step.name,
      email_id: step.email_id,
      subject: step.subject,
      from_name: step.from_name,
      from: step.from,
      reply_to: step.reply_to,
    }))

  const uniqueLinks = Array.from(new Set(Object.values(FLOW_SPEC).flatMap((spec) => spec.buttons.map((b) => b.href))))
  const linkChecks = []
  for (const link of uniqueLinks) {
    linkChecks.push(await verifyLink(link))
  }

  const output = {
    dry_run: DRY_RUN,
    automation: {
      id: refreshed.data?.id ?? automation.id,
      name: refreshed.data?.name ?? automation.name,
      enabled: refreshed.data?.enabled ?? null,
      trigger_group_ids: refreshed.data?.triggers?.flatMap((t) => t.group_ids ?? []) ?? [],
      expected_group_id: groupId,
    },
    sender: {
      from_name: SENDER_NAME,
      from: SENDER_EMAIL,
      reply_to: REPLY_TO,
    },
    updated_emails: updates,
    refreshed_emails: refreshedEmails,
    link_checks: linkChecks,
  }

  console.log(JSON.stringify(output, null, 2))
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : String(error))
  process.exit(1)
})
