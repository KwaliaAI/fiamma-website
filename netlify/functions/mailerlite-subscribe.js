export const handler = async (event) => {
  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      body: JSON.stringify({ error: 'Method not allowed' }),
      headers: { 'Content-Type': 'application/json' },
    }
  }

  let payload
  try {
    payload = JSON.parse(event.body || '{}')
  } catch {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: 'Invalid JSON body' }),
      headers: { 'Content-Type': 'application/json' },
    }
  }

  const email = String(payload.email || '')
    .trim()
    .toLowerCase()
  if (!email) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: 'Missing email' }),
      headers: { 'Content-Type': 'application/json' },
    }
  }

  const apiKey = process.env.MAILERLITE_API_KEY
  const groupId = process.env.MAILERLITE_GROUP_ID

  if (!apiKey || !groupId) {
    return {
      statusCode: 202,
      body: JSON.stringify({ ok: false, skipped: true, reason: 'Missing MailerLite config' }),
      headers: { 'Content-Type': 'application/json' },
    }
  }

  try {
    const response = await fetch('https://connect.mailerlite.com/api/subscribers', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${apiKey}`,
      },
      body: JSON.stringify({
        email,
        groups: [groupId],
      }),
    })

    if (!response.ok) {
      const body = await response.text().catch(() => '')
      console.warn('MailerLite subscribe failed (server-side)', {
        status: response.status,
        body: body.slice(0, 300),
      })
      return {
        statusCode: 202,
        body: JSON.stringify({ ok: false, status: response.status }),
        headers: { 'Content-Type': 'application/json' },
      }
    }

    return {
      statusCode: 200,
      body: JSON.stringify({ ok: true }),
      headers: { 'Content-Type': 'application/json' },
    }
  } catch (error) {
    console.warn('MailerLite subscribe transport error (server-side)', { error: String(error) })
    return {
      statusCode: 202,
      body: JSON.stringify({ ok: false, transport: true }),
      headers: { 'Content-Type': 'application/json' },
    }
  }
}
