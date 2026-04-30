import { useEffect, useMemo, useState } from 'react'
import type { FormEvent } from 'react'
import { Link, useParams } from 'react-router-dom'
import { BookCard } from '@/components/BookCard'
import { getVisibleBooks } from '@/lib/fiammaApi'
import { getImprintBySlug, getBookImprint } from '@/lib/fiammaBrand'
import { getHeteronymProfilesByImprint } from '@/lib/heteronyms'
import { subscribeReader } from '@/lib/mailerlite'
import type { FiammaBook } from '@/types/fiamma'

export function ImprintPage() {
  const { slug = '' } = useParams()
  const imprint = useMemo(() => getImprintBySlug(slug), [slug])
  const [books, setBooks] = useState<FiammaBook[]>([])
  const [signupEmail, setSignupEmail] = useState('')
  const [signupState, setSignupState] = useState<'idle' | 'sending' | 'sent'>('idle')

  useEffect(() => {
    getVisibleBooks().then(setBooks).catch(() => setBooks([]))
  }, [])

  const imprintBooks = useMemo(
    () => books.filter((book) => getBookImprint(book).id === imprint?.id),
    [books, imprint?.id],
  )

  const relatedProfiles = useMemo(() => (imprint ? getHeteronymProfilesByImprint(imprint.id) : []), [imprint])

  const handleSignup = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    const email = signupEmail.trim().toLowerCase()
    if (!email) return
    setSignupState('sending')
    await subscribeReader(email)
    setSignupState('sent')
  }

  if (!imprint || !imprint.public) {
    return (
      <main className="section-padding pt-32 md:pt-40">
        <div className="mx-auto max-w-3xl text-center">
          <h1 className="mb-4 font-display text-4xl font-bold">Imprint not found.</h1>
          <p className="mb-8 text-gray-600">This imprint page is not available yet.</p>
          <Link
            to="/imprints"
            className="inline-block rounded-full bg-fiamma-coral px-6 py-3 font-semibold text-white transition-colors hover:bg-fiamma-dark"
          >
            Back to imprints
          </Link>
        </div>
      </main>
    )
  }

  return (
    <main className="section-padding pt-32 md:pt-40">
      <div className="mx-auto max-w-6xl">
        <Link to="/imprints" className="mb-6 inline-block text-sm font-semibold text-fiamma-coral hover:text-fiamma-dark">
          Back to imprints
        </Link>

        <section className="mb-14 grid gap-10 lg:grid-cols-[1.1fr,0.9fr] lg:items-start">
          <div>
            <p className="mb-3 text-sm font-semibold uppercase tracking-[0.28em] text-fiamma-coral">Imprint</p>
            <h1 className="mb-4 font-display text-5xl font-bold text-fiamma-text md:text-6xl">{imprint.title}</h1>
            <p className="mb-4 max-w-3xl text-lg leading-8 text-gray-700">{imprint.positioning}</p>
            <p className="mb-6 max-w-3xl text-base leading-8 text-gray-700">{imprint.shortDescription}</p>

            {relatedProfiles.length > 0 ? (
              <p className="mb-6 text-sm text-gray-500">
                Voices in this lane: {relatedProfiles.map((profile) => profile.name).join(', ')}.
              </p>
            ) : null}

            {imprint.showSignup ? (
              <div className="max-w-xl rounded-2xl border border-fiamma-coral/20 bg-fiamma-coral/5 p-5">
                <p className="mb-3 text-sm text-gray-700">
                  Seph Blackwood is next in this lane. Join the list for first access and release updates.
                </p>
                <form onSubmit={handleSignup} className="space-y-3">
                  <input
                    type="email"
                    required
                    value={signupEmail}
                    onChange={(event) => setSignupEmail(event.target.value)}
                    placeholder="you@example.com"
                    className="w-full rounded-xl border border-gray-300 bg-white px-4 py-3 text-fiamma-text outline-none transition-colors focus:border-fiamma-coral"
                  />
                  <button
                    type="submit"
                    disabled={signupState === 'sending'}
                    className="w-full rounded-full bg-fiamma-coral px-6 py-3 font-semibold text-white transition-colors hover:bg-fiamma-dark disabled:opacity-70"
                  >
                    {signupState === 'sending' ? 'Sending...' : 'Join Fuoco updates'}
                  </button>
                  {signupState === 'sent' ? <p className="text-sm text-gray-600">You are on the list.</p> : null}
                </form>
              </div>
            ) : null}
          </div>

          <div className="rounded-3xl border border-gray-200 bg-white p-8 shadow-sm">
            <p className="mb-3 text-xs font-semibold uppercase tracking-[0.24em] text-fiamma-coral">Books</p>
            <h2 className="mb-6 font-display text-3xl font-bold">Titles in this lane</h2>
            {imprintBooks.length > 0 ? (
              <div className="grid gap-6">
                {imprintBooks.map((book) => (
                  <BookCard key={book.title_id} book={book} ctaLabel="Open book" />
                ))}
              </div>
            ) : (
              <p className="text-gray-600">No visible titles yet.</p>
            )}
          </div>
        </section>
      </div>
    </main>
  )
}
