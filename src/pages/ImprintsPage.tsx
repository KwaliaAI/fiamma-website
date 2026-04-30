import { useEffect, useMemo, useState } from 'react'
import type { FormEvent } from 'react'
import { Link } from 'react-router-dom'
import { BookCard } from '@/components/BookCard'
import { getVisibleBooks } from '@/lib/fiammaApi'
import { FIAMMA_IMPRINTS, getBookImprint, getPublicImprints } from '@/lib/fiammaBrand'
import { getHeteronymProfilesByImprint } from '@/lib/heteronyms'
import { subscribeReader } from '@/lib/mailerlite'
import type { FiammaBook } from '@/types/fiamma'

export function ImprintsPage() {
  const [books, setBooks] = useState<FiammaBook[]>([])
  const [signupEmail, setSignupEmail] = useState('')
  const [signupState, setSignupState] = useState<'idle' | 'sending' | 'sent'>('idle')

  useEffect(() => {
    getVisibleBooks().then(setBooks).catch(() => setBooks([]))
  }, [])

  const publicImprints = useMemo(() => getPublicImprints(), [])
  const booksByImprint = useMemo(() => {
    const grouped = new Map<string, FiammaBook[]>()
    for (const imprint of FIAMMA_IMPRINTS) grouped.set(imprint.id, [])
    for (const book of books) {
      const imprint = getBookImprint(book)
      const bucket = grouped.get(imprint.id)
      if (bucket) bucket.push(book)
    }
    return grouped
  }, [books])

  const handleSignup = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    const email = signupEmail.trim().toLowerCase()
    if (!email) return
    setSignupState('sending')
    await subscribeReader(email)
    setSignupState('sent')
  }

  return (
    <main className="section-padding pt-32 md:pt-40">
      <div className="mx-auto max-w-6xl">
        <div className="mx-auto mb-12 max-w-3xl text-center">
          <p className="mb-3 text-sm font-semibold uppercase tracking-[0.28em] text-fiamma-coral">Imprints</p>
          <h1 className="mb-4 font-display text-5xl font-bold">Find the right flame</h1>
          <p className="text-lg leading-8 text-gray-700">
            Fiamma uses four brand lanes to signal the kind of reading experience a title is built to deliver. The public
            site highlights the active lanes and links each title back to the right world.
          </p>
        </div>

        <div className="grid gap-8 lg:grid-cols-3">
          {publicImprints.map((imprint) => {
            const imprintBooks = booksByImprint.get(imprint.id) ?? []
            const relatedProfiles = getHeteronymProfilesByImprint(imprint.id)

            return (
              <section key={imprint.id} className="rounded-3xl border border-gray-200 bg-white p-8 shadow-sm">
                <p className="mb-3 text-xs font-semibold uppercase tracking-[0.24em] text-fiamma-coral">{imprint.title}</p>
                <h2 className="mb-3 font-display text-3xl font-bold">{imprint.positioning}</h2>
                <p className="mb-6 text-gray-700">{imprint.shortDescription}</p>

                {relatedProfiles.length > 0 ? (
                  <p className="mb-4 text-sm text-gray-500">
                    Written by {relatedProfiles.map((profile) => profile.name).join(', ')}.
                  </p>
                ) : null}

                {imprintBooks.length > 0 ? (
                  <div className="mb-6 grid gap-4">
                    {imprintBooks.slice(0, 2).map((book) => (
                      <BookCard key={book.title_id} book={book} ctaLabel="Open book" />
                    ))}
                  </div>
                ) : imprint.showSignup ? (
                  <div className="mb-6 rounded-2xl border border-fiamma-coral/20 bg-fiamma-coral/5 p-5">
                    <p className="mb-3 text-sm text-gray-700">
                      Seph Blackwood is next for this lane. Get the first notice when the line opens.
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

                <Link
                  to={`/imprints/${imprint.slug}`}
                  className="inline-flex rounded-full border border-fiamma-coral px-4 py-2 text-sm font-semibold text-fiamma-coral transition-colors hover:bg-fiamma-coral hover:text-white"
                >
                  Open imprint page
                </Link>
              </section>
            )
          })}
        </div>
      </div>
    </main>
  )
}
