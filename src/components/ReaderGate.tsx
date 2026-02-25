import { useState } from 'react'
import type { FormEvent } from 'react'

type ReaderGateProps = {
  title: string
  onSendLink: (email: string) => Promise<void>
  onVerifyOtp: (email: string, otp: string) => Promise<void>
}

export function ReaderGate({ title, onSendLink, onVerifyOtp }: ReaderGateProps) {
  const [email, setEmail] = useState('')
  const [otp, setOtp] = useState('')
  const [mode, setMode] = useState<'magic' | 'otp'>('magic')
  const [linkSent, setLinkSent] = useState(false)
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const formatSendError = (caught: unknown): string => {
    if (caught && typeof caught === 'object') {
      const status = 'status' in caught ? Number(caught.status) : null
      const code = 'code' in caught ? String(caught.code) : ''
      const message = 'message' in caught ? String(caught.message) : ''
      if (status === 429 || code === 'over_email_send_rate_limit' || message.includes('over_email_send_rate_limit')) {
        return 'You already requested a link recently. Please wait about 60 seconds, then try again. Also check spam/promotions.'
      }
    }
    return 'Could not send access right now. Please try again.'
  }

  const handleSend = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    if (!email.trim()) return

    setSubmitting(true)
    setError(null)
    try {
      await onSendLink(email.trim().toLowerCase())
      setLinkSent(true)
    } catch (caught) {
      setError(formatSendError(caught))
    } finally {
      setSubmitting(false)
    }
  }

  const handleVerify = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    if (!email.trim() || !otp.trim()) return

    setSubmitting(true)
    setError(null)
    try {
      await onVerifyOtp(email.trim().toLowerCase(), otp.trim())
    } catch {
      setError('That code did not work. Request a new one and retry.')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div className="mx-auto mt-6 max-w-md">
      <form onSubmit={handleSend} className="space-y-4">
        <input
          type="email"
          required
          value={email}
          onChange={(event) => setEmail(event.target.value)}
          placeholder="you@example.com"
          className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-fiamma-text outline-none transition-colors focus:border-fiamma-coral"
        />
        <button
          type="submit"
          disabled={submitting}
          className="w-full rounded-full bg-fiamma-coral px-6 py-3 font-semibold text-white transition-colors hover:bg-fiamma-dark disabled:opacity-70"
        >
          {submitting ? 'Sending...' : `Send reading link for ${title}`}
        </button>
        <p className="text-sm text-gray-600">Complimentary reads: your first two books are on us.</p>
      </form>

      {linkSent ? (
        <p className="mt-3 text-sm text-gray-600">
          Check your inbox for a one-tap sign-in link. You can also use a one-time code below if your mail app blocks links.
        </p>
      ) : null}

      <button
        type="button"
        onClick={() => setMode((current) => (current === 'magic' ? 'otp' : 'magic'))}
        className="mt-4 text-sm font-medium text-fiamma-coral underline"
      >
        {mode === 'magic' ? 'Use a one-time code instead' : 'Use magic link instead'}
      </button>

      {mode === 'otp' ? (
        <form onSubmit={handleVerify} className="mt-4 space-y-3">
          <input
            type="text"
            inputMode="numeric"
            value={otp}
            onChange={(event) => setOtp(event.target.value)}
            placeholder="Enter 6-digit code"
            className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-fiamma-text outline-none transition-colors focus:border-fiamma-coral"
          />
          <button
            type="submit"
            disabled={submitting}
            className="w-full rounded-full border border-fiamma-coral px-6 py-3 font-semibold text-fiamma-coral transition-colors hover:bg-fiamma-coral hover:text-white disabled:opacity-70"
          >
            {submitting ? 'Verifying...' : 'Verify code and start reading'}
          </button>
        </form>
      ) : null}

      {error ? <p className="mt-3 text-sm text-red-600">{error}</p> : null}
    </div>
  )
}
