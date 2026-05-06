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

async function sendNewReaderAlert(email) {
  const smtpUser = process.env.KWALIA_SMTP_USER
  const smtpPassword = process.env.KWALIA_SMTP_PASSWORD
  const smtpHost = process.env.KWALIA_SMTP_HOST
  const smtpPort = Number(process.env.KWALIA_SMTP_PORT || '587')
  const alertTo = process.env.FIAMMA_NEW_READER_ALERT_TO || smtpUser

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
    from: smtpUser,
    to: alertTo,
    subject: `New Fiamma reader: ${email}`,
    text: `A new Fiamma reader signed in.\n\nEmail: ${email}\nTimestamp: ${new Date().toISOString()}\n`,
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
