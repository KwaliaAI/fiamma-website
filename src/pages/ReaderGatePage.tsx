import { useCallback, useEffect, useRef, useState } from 'react'
import { Link, useNavigate, useParams } from 'react-router-dom'
import { ReaderGate } from '@/components/ReaderGate'
import {
  claimGiftUnlock,
  getBookBySlug,
  getReaderGiftStatus,
  getReaderSession,
  sendReaderAccess,
  upsertReaderProfile,
  verifyReaderOtp,
} from '@/lib/fiammaApi'
import { subscribeReader } from '@/lib/mailerlite'
import { setReaderToken } from '@/lib/readerGate'
import { supabase } from '@/lib/supabase'
import type { FiammaBook } from '@/types/fiamma'

export function ReaderGatePage() {
  const { slug = '' } = useParams()
  const navigate = useNavigate()
  const [book, setBook] = useState<FiammaBook | null>(null)
  const [giftCreditsRemaining, setGiftCreditsRemaining] = useState<number | null>(null)
  const [giftCreditsTotal, setGiftCreditsTotal] = useState<number>(1)
  const [accessBlocked, setAccessBlocked] = useState(false)
  const [statusError, setStatusError] = useState<string | null>(null)
  const [retrying, setRetrying] = useState(false)
  const processingRef = useRef(false)
  const subscribedEmailRef = useRef<string | null>(null)

  const getErrorCode = (error: unknown): string | null => {
    if (error && typeof error === 'object' && 'code' in error && typeof error.code === 'string') return error.code
    if (error && typeof error === 'object' && 'status' in error && typeof error.status === 'number') return String(error.status)
    return null
  }

  const waitForSession = useCallback(async (attempts = 8, delayMs = 350) => {
    for (let attempt = 0; attempt < attempts; attempt += 1) {
      const session = await getReaderSession()
      if (session?.user) return session
      await new Promise((resolve) => setTimeout(resolve, delayMs))
    }
    return null
  }, [])

  const claimAndRoute = useCallback(
    async (bookId: string): Promise<boolean> => {
      setStatusError(null)
      setAccessBlocked(false)

      const result = await claimGiftUnlock(bookId)
      setGiftCreditsRemaining(result.gift_credits_remaining)
      setGiftCreditsTotal(result.gift_credits_total)

      if (result.status === 'unlocked' || result.status === 'already_unlocked') {
        navigate(`/read/${slug}/1`, { replace: true })
        return true
      }

      setAccessBlocked(true)
      return false
    },
    [navigate, slug],
  )

  const claimWithRetry = useCallback(
    async (bookId: string): Promise<boolean> => {
      let lastError: unknown = null
      for (let attempt = 0; attempt < 4; attempt += 1) {
        try {
          return await claimAndRoute(bookId)
        } catch (error) {
          lastError = error
          await new Promise((resolve) => setTimeout(resolve, 450 * (attempt + 1)))
        }
      }
      throw lastError
    },
    [claimAndRoute],
  )

  const processSession = useCallback(
    async (sessionUserEmail: string | null | undefined, bookId: string) => {
      if (processingRef.current) return
      processingRef.current = true
      try {
        const email = (sessionUserEmail ?? '').trim().toLowerCase()
        if (email) {
          setReaderToken(email)
          await upsertReaderProfile(email)
          if (subscribedEmailRef.current !== email) {
            await subscribeReader(email)
            subscribedEmailRef.current = email
          }
        }

        const status = await getReaderGiftStatus(bookId)
        setGiftCreditsRemaining(status.giftCreditsRemaining)
        setGiftCreditsTotal(status.giftCreditsTotal)

        if (status.isUnlocked) {
          navigate(`/read/${slug}/1`, { replace: true })
          return
        }

        await claimWithRetry(bookId)
      } catch (error) {
        const code = getErrorCode(error)
        console.error('Gift access flow failed', { error, code, slug, bookId })
        setStatusError(`We could not check your complimentary access right now${code ? ` (${code})` : ''}. Please try again.`)
      } finally {
        processingRef.current = false
      }
    },
    [claimWithRetry, navigate, slug],
  )

  useEffect(() => {
    getBookBySlug(slug).then(setBook)
  }, [slug])

  useEffect(() => {
    if (!book) return

    let isActive = true

    const run = async (sessionOverride?: Awaited<ReturnType<typeof getReaderSession>> | null) => {
      if (!isActive) return
      const session = sessionOverride?.user ? sessionOverride : await waitForSession()
      if (!isActive || !session?.user) return
      await processSession(session.user.email, book.title_id)
    }

    void run()

    const { data: authSubscription } = supabase?.auth.onAuthStateChange((_event, session) => {
      void run(session)
    }) ?? { data: { subscription: null } }

    return () => {
      isActive = false
      authSubscription.subscription?.unsubscribe()
    }
  }, [book, processSession, waitForSession])

  const handleSendLink = async (email: string) => {
    await sendReaderAccess(email, slug, 'magic_link')
  }

  const handleVerifyOtp = async (email: string, otp: string) => {
    await verifyReaderOtp(email, otp)
    setReaderToken(email)

    if (!book) return
    const session = await waitForSession()
    if (!session?.user) {
      setStatusError('Sign-in is still being finalized. Please tap access again in a second.')
      return
    }

    await processSession(session.user.email, book.title_id)
  }

  const handleRetry = async () => {
    if (!book || retrying) return
    setRetrying(true)
    setStatusError(null)
    try {
      const session = await waitForSession()
      if (!session?.user) {
        setStatusError('Still having trouble finalizing sign-in. Please tap again in a few seconds.')
        return
      }

      await processSession(session.user.email, book.title_id)
    } catch (error) {
      const code = getErrorCode(error)
      setStatusError(`Still having trouble checking access${code ? ` (${code})` : ''}. Please tap again in a few seconds.`)
    } finally {
      setRetrying(false)
    }
  }

  if (!book) {
    return (
      <main className="section-padding pt-32 md:pt-40">
        <p className="text-center text-gray-600">This title is not ready to read yet.</p>
      </main>
    )
  }

  return (
    <main className="section-padding pt-32 md:pt-40">
      <div className="mx-auto max-w-2xl text-center">
        <p className="mb-2 text-sm font-semibold uppercase tracking-wide text-fiamma-coral">Fiamma reader</p>
        <h1 className="mb-2 font-display text-5xl font-bold">Read {book.title}</h1>
        <p className="mb-4 text-gray-600">Your first two reads are our gift. Keep each one on your shelf forever once unlocked.</p>

        {giftCreditsRemaining !== null ? (
          <p className="mx-auto mb-6 max-w-xl rounded-lg border border-fiamma-coral/30 bg-fiamma-coral/10 px-4 py-3 text-sm text-fiamma-text">
            Complimentary reads remaining: <span className="font-semibold">{giftCreditsRemaining}</span> of {giftCreditsTotal}
          </p>
        ) : null}

        {accessBlocked ? (
          <div className="mx-auto mb-6 max-w-xl rounded-lg border border-amber-200 bg-amber-50 px-4 py-4 text-left text-amber-900">
            <p className="mb-2 text-sm font-semibold">Your complimentary read has been used.</p>
            <p className="text-sm">This title will be available through retail editions. Check back soon for the next release.</p>
            <Link to={`/books/${book.slug}`} className="mt-3 inline-block text-sm font-semibold text-fiamma-coral underline">
              Back to book page
            </Link>
          </div>
        ) : null}

        {statusError ? (
          <div className="mb-4">
            <p className="mb-3 text-sm text-red-600">{statusError}</p>
            <button
              type="button"
              onClick={handleRetry}
              disabled={retrying}
              className="rounded-full border border-fiamma-coral px-4 py-2 text-sm font-semibold text-fiamma-coral hover:bg-fiamma-coral hover:text-white disabled:opacity-60"
            >
              {retrying ? 'Retrying...' : 'Try access again'}
            </button>
          </div>
        ) : null}

        {!accessBlocked ? <ReaderGate title={book.title} onSendLink={handleSendLink} onVerifyOtp={handleVerifyOtp} /> : null}
      </div>
    </main>
  )
}
