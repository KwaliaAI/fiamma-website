import { useEffect, useMemo, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { getBookBySlug, getReaderGiftStatus, getVisibleBooks } from '@/lib/fiammaApi'
import type { FiammaBook } from '@/types/fiamma'

export function BookPage() {
  const { slug = '' } = useParams()
  const [book, setBook] = useState<FiammaBook | null>(null)
  const [allBooks, setAllBooks] = useState<FiammaBook[]>([])
  const [giftCreditsRemaining, setGiftCreditsRemaining] = useState<number | null>(null)
  const [giftCreditsTotal, setGiftCreditsTotal] = useState<number>(1)
  const [isUnlocked, setIsUnlocked] = useState(false)

  useEffect(() => {
    getBookBySlug(slug).then(setBook)
    getVisibleBooks().then(setAllBooks)
  }, [slug])

  useEffect(() => {
    if (!book) return
    getReaderGiftStatus(book.title_id)
      .then((status) => {
        if (!status.isAuthenticated) {
          setGiftCreditsRemaining(null)
          setGiftCreditsTotal(1)
          setIsUnlocked(false)
          return
        }

        setGiftCreditsRemaining(status.giftCreditsRemaining)
        setGiftCreditsTotal(status.giftCreditsTotal)
        setIsUnlocked(status.isUnlocked)
      })
      .catch(() => {
        setGiftCreditsRemaining(null)
        setGiftCreditsTotal(1)
        setIsUnlocked(false)
      })
  }, [book])

  const relatedByHeteronym = useMemo(() => {
    if (!book) return []
    return allBooks.filter((candidate) => candidate.heteronym === book.heteronym && candidate.slug !== book.slug)
  }, [allBooks, book])

  if (!book) {
    return (
      <main className="section-padding pt-32 md:pt-40">
        <p className="text-center text-gray-600">Book not found.</p>
      </main>
    )
  }

  return (
    <main className="section-padding pt-32 md:pt-40">
      <div className="mx-auto grid max-w-6xl gap-10 md:grid-cols-[320px,1fr]">
        <div>
          {book.cover_url ? (
            <img src={book.cover_url} alt={book.title} className="w-full rounded-2xl object-cover shadow-lg" />
          ) : (
            <div className="flex aspect-[2/3] items-center justify-center rounded-2xl bg-gradient-to-br from-fiamma-coral/20 to-fiamma-coral/40 text-fiamma-coral">
              Cover coming soon
            </div>
          )}
        </div>

        <div>
          <p className="mb-2 text-sm font-semibold uppercase tracking-wide text-fiamma-coral">{book.fiamma_line ?? 'Fiamma'}</p>
          <h1 className="mb-2 font-display text-5xl font-bold">{book.title}</h1>
          <p className="mb-6 text-lg text-gray-600">by {book.heteronym}</p>
          <p className="mb-8 whitespace-pre-line text-gray-700">{book.blurb_300 ?? book.blurb_short ?? 'Coming soon.'}</p>

          <Link
            to={`/read/${book.slug}`}
            className="mb-8 inline-block w-full rounded-full bg-fiamma-coral px-6 py-4 text-center font-semibold text-white transition-colors hover:bg-fiamma-dark"
          >
            {isUnlocked ? 'Continue reading' : 'Start complimentary read'}
          </Link>

          {giftCreditsRemaining !== null ? (
            <p className="mb-8 rounded-lg border border-fiamma-coral/30 bg-fiamma-coral/10 px-4 py-3 text-sm text-fiamma-text">
              Complimentary reads remaining: <span className="font-semibold">{giftCreditsRemaining}</span> of {giftCreditsTotal}
            </p>
          ) : (
            <p className="mb-8 rounded-lg border border-fiamma-coral/30 bg-fiamma-coral/10 px-4 py-3 text-sm text-fiamma-text">
              Your first two reads are complimentary.
            </p>
          )}

          {giftCreditsRemaining === 0 && !isUnlocked ? (
            <p className="mb-8 rounded-lg border border-amber-200 bg-amber-50 px-4 py-3 text-sm text-amber-900">
              You have used your complimentary read. This title will be available through retail editions.
            </p>
          ) : null}

          <section className="mb-10">
            <h2 className="mb-4 font-display text-3xl font-bold">Own it</h2>
            <div className="flex flex-wrap gap-3">
              {book.buy_url_amazon ? (
                <a
                  href={book.buy_url_amazon}
                  target="_blank"
                  rel="noreferrer"
                  className="rounded-full bg-fiamma-coral px-5 py-2 text-sm font-semibold text-white transition-colors hover:bg-fiamma-dark"
                >
                  Amazon PB
                </a>
              ) : null}
              {book.buy_url_ebook ? (
                <a
                  href={book.buy_url_ebook}
                  target="_blank"
                  rel="noreferrer"
                  className="rounded-full bg-fiamma-coral px-5 py-2 text-sm font-semibold text-white transition-colors hover:bg-fiamma-dark"
                >
                  Ebook
                </a>
              ) : null}
              {book.buy_url_audio ? (
                <a
                  href={book.buy_url_audio}
                  target="_blank"
                  rel="noreferrer"
                  className="rounded-full bg-fiamma-coral px-5 py-2 text-sm font-semibold text-white transition-colors hover:bg-fiamma-dark"
                >
                  Audio
                </a>
              ) : null}
            </div>
          </section>

          <section>
            <h2 className="mb-3 font-display text-2xl font-bold">About the Author</h2>
            <p className="mb-5 text-gray-700">
              {book.heteronym} writes emotionally charged romance for Fiamma readers who want heat, tension, and unforgettable characters.
            </p>

            <h3 className="mb-3 font-display text-xl font-bold">Also by {book.heteronym}</h3>
            {relatedByHeteronym.length === 0 ? (
              <p className="text-gray-600">More titles coming soon.</p>
            ) : (
              <div className="flex flex-wrap gap-3">
                {relatedByHeteronym.map((related) => (
                  <Link
                    key={related.title_id}
                    to={`/books/${related.slug}`}
                    className="rounded-full border border-fiamma-coral px-4 py-2 text-sm font-semibold text-fiamma-coral hover:bg-fiamma-coral hover:text-white"
                  >
                    {related.title}
                  </Link>
                ))}
              </div>
            )}
          </section>
        </div>
      </div>
    </main>
  )
}
