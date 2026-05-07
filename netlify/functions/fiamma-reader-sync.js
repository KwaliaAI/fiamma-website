import { createClient } from '@supabase/supabase-js'
import nodemailer from 'nodemailer'

const JSON_HEADERS = { 'Content-Type': 'application/json' }

function jsonResponse(statusCode, body) {
  return {
    statusCode,
    headers: JSON_HEADERS,
    body: JSON.stringify(body),
  }
}

function normalizeEmail(email) {
  return String(email || '')
    .trim()
    .toLowerCase()
}

function isSuppressedAlertEmail(email) {
  return email.endsWith('@example.com') || email.endsWith('@kwalia.ai')
}

function base64UrlEncode(value) {
  return Buffer.from(value, 'utf8').toString('base64').replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/g, '')
}

function buildReaderAlertMessage({ from, to, email }) {
  const subject = `New Fiamma reader: ${email}`
  const text = `A new Fiamma reader signed in.\n\nEmail: ${email}\nTimestamp: ${new Date().toISOString()}\n`

  return [
    `From: ${from}`,
    `To: ${to}`,
    `Subject: ${subject}`,
    'MIME-Version: 1.0',
    'Content-Type: text/plain; charset=UTF-8',
    '',
    text,
  ].join('\r\n')
}

async function getGmailAccessToken() {
  const clientId = process.env.KWALIA_GMAIL_CLIENT_ID
  const clientSecret = process.env.KWALIA_GMAIL_CLIENT_SECRET
  const refreshToken = process.env.KWALIA_GMAIL_REFRESH_TOKEN

  if (!clientId || !clientSecret || !refreshToken) {
    throw new Error('Missing Gmail API env for Fiamma reader alerts')
  }

  const response = await fetch('https://oauth2.googleapis.com/token', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: new URLSearchParams({
      client_id: clientId,
      client_secret: clientSecret,
      refresh_token: refreshToken,
      grant_type: 'refresh_token',
    }),
  })

  if (!response.ok) {
    const body = await response.text().catch(() => '')
    throw new Error(`Gmail token refresh failed (${response.status}): ${body.slice(0, 200)}`)
  }

  const body = await response.json()
  if (!body.access_token) {
    throw new Error('Gmail token refresh returned no access token')
  }
  return body.access_token
}

async function sendNewReaderAlertWithGmailApi({ email, from, alertTo }) {
  const accessToken = await getGmailAccessToken()
  const raw = base64UrlEncode(buildReaderAlertMessage({ from, to: alertTo, email }))
  const response = await fetch('https://gmail.googleapis.com/gmail/v1/users/me/messages/send', {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${accessToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ raw }),
  })

  if (!response.ok) {
    const body = await response.text().catch(() => '')
    throw new Error(`Gmail send failed (${response.status}): ${body.slice(0, 200)}`)
  }
}

async function sendNewReaderAlert(email) {
  const smtpUser = process.env.KWALIA_SMTP_USER
  const smtpPassword = process.env.KWALIA_SMTP_PASSWORD
  const smtpHost = process.env.KWALIA_SMTP_HOST
  const smtpPort = Number(process.env.KWALIA_SMTP_PORT || '587')
  const alertTo = process.env.FIAMMA_NEW_READER_ALERT_TO || smtpUser

  if (process.env.KWALIA_GMAIL_REFRESH_TOKEN) {
    if (!smtpUser || !alertTo) {
      throw new Error('Missing Gmail sender env for Fiamma reader alerts')
    }
    await sendNewReaderAlertWithGmailApi({ email, from: smtpUser, alertTo })
    return
  }

  if (!smtpUser || !smtpPassword || !smtpHost || !alertTo) {
    throw new Error('Missing SMTP env for Fiamma reader alerts')
  }

  const transporter = nodemailer.createTransport({
    host: smtpHost,
    port: smtpPort,
    secure: smtpPort === 465,
    auth: {
      user: smtpUser,
      pass: smtpPassword,
    },
  })

  await transporter.sendMail({
    envelope: {
      from: smtpUser,
      to: alertTo,
    },
    raw: buildReaderAlertMessage({ from: smtpUser, to: alertTo, email }),
  })
}

export const handler = async (event) => {
  if (event.httpMethod !== 'POST') {
    return jsonResponse(405, { error: 'Method not allowed' })
  }

  const authorization = event.headers.authorization || event.headers.Authorization || ''
  const token = authorization.startsWith('Bearer ') ? authorization.slice('Bearer '.length).trim() : ''
  if (!token) {
    return jsonResponse(401, { error: 'Missing bearer token' })
  }

  const supabaseUrl = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL
  const supabaseAnonKey = process.env.VITE_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY
  if (!supabaseUrl || !supabaseAnonKey) {
    return jsonResponse(500, { error: 'Missing Supabase config' })
  }

  const supabase = createClient(supabaseUrl, supabaseAnonKey, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
    },
    global: {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    },
  })

  const {
    data: { user },
    error: userError,
  } = await supabase.auth.getUser(token)

  if (userError || !user) {
    return jsonResponse(401, { error: 'Invalid user token' })
  }

  const email = normalizeEmail(user.email)
  if (!email) {
    return jsonResponse(400, { error: 'Authenticated user has no email' })
  }

  const { data, error } = await supabase.rpc('fiamma_touch_reader_profile', { p_email: email })
  if (error) {
    console.error('Reader profile sync failed', { error, email })
    return jsonResponse(500, { error: 'Reader profile sync failed' })
  }

  const created = Boolean(data?.created)
  let notified = false
  let notificationSkipped = false
  let notificationError = null

  if (created) {
    if (isSuppressedAlertEmail(email)) {
      notificationSkipped = true
    } else {
      try {
        await sendNewReaderAlert(email)
        notified = true
      } catch (alertError) {
        console.error('New reader alert failed', {
          email,
          error: alertError instanceof Error ? alertError.message : String(alertError),
        })
        notificationError = alertError instanceof Error ? alertError.message : String(alertError)
      }
    }
  }

  return jsonResponse(200, {
    ok: true,
    created,
    notified,
    notificationSkipped,
    notificationError,
    email,
  })
}
