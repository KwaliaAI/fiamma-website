const JSON_HEADERS = { 'Content-Type': 'application/json' }

function jsonResponse(statusCode, body) {
  return {
    statusCode,
    body: JSON.stringify(body),
    headers: JSON_HEADERS,
  }
}

export const handler = async (event) => {
  if (event.httpMethod !== 'POST') {
    return jsonResponse(405, { error: 'Method not allowed' })
  }

  let payload
  try {
    payload = JSON.parse(event.body || '{}')
  } catch {
    return jsonResponse(400, { error: 'Invalid JSON body' })
  }

  const email = String(payload.email || '')
    .trim()
    .toLowerCase()
  if (!email) {
    return jsonResponse(400, { error: 'Missing email' })
  }

  const apiKey = process.env.MAILERLITE_API_KEY
  const groupId = process.env.MAILERLITE_GROUP_ID

  if (!apiKey || !groupId) {
    console.warn('MailerLite subscribe misconfigured', {
      hasApiKey: Boolean(apiKey),
      hasGroupId: Boolean(groupId),
    })
    return jsonResponse(500, {
      ok: false,
      error: 'server_misconfigured',
    })
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
      return jsonResponse(502, {
        ok: false,
        error: 'mailerlite_upstream_error',
        upstreamStatus: response.status,
      })
    }

    return jsonResponse(200, { ok: true })
  } catch (error) {
    console.warn('MailerLite subscribe transport error (server-side)', { error: String(error) })
    return jsonResponse(503, {
      ok: false,
      error: 'mailerlite_unavailable',
      transport: true,
    })
  }
}
