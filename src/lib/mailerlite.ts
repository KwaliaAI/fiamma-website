export async function subscribeReader(email: string): Promise<void> {
  try {
    const response = await fetch('/.netlify/functions/mailerlite-subscribe', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        email,
      }),
    })

    if (!response.ok) {
      const body = await response.text().catch(() => '')
      console.warn('MailerLite subscribe failed', {
        status: response.status,
        body: body.slice(0, 300),
      })
    }
  } catch (error) {
    console.warn('MailerLite subscribe transport failed', {
      error: error instanceof Error ? error.message : String(error),
    })
  }
}
