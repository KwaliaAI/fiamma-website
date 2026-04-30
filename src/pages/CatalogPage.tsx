import { useEffect, useState } from 'react'
import { BookCard } from '@/components/BookCard'
import { getReaderGiftBalance, getVisibleBooks } from '@/lib/fiammaApi'
import { complimentaryReaderSummary } from '@/lib/readerPolicy'
import type { FiammaBook } from '@/types/fiamma'

export function CatalogPage() {
  const [books, setBooks] = useState<FiammaBook[]>([])
  const [error, setError] = useState<string | null>(null)
  const [giftMeter, setGiftMeter] = useState<{ remaining: number; total: number } | null>(null)

  useEffect(() => {
    getVisibleBooks().then(setBooks).catch(() => setError('Could not load books right now.'))
    getReaderGiftBalance()
      .then((balance) => {
        if (!balance.isAuthenticated) return
        setGiftMeter({ remaining: balance.giftCreditsRemaining, total: balance.giftCreditsTotal })
      })
      .catch(() => setGiftMeter(null))
  }, [])

  return (
    <main className="section-padding pt-32 md:pt-40">
      <div className="mx-auto max-w-6xl">
        <h1 className="mb-4 text-center font-display text-5xl font-bold">Our Books</h1>
        <p className="mx-auto mb-2 max-w-2xl text-center text-gray-600">
          Discover books by our heteronyms. Start with a complimentary read.
        </p>
        <p className="mx-auto mb-12 max-w-2xl text-center text-sm text-gray-500">
          {complimentaryReaderSummary()}
        </p>

        {giftMeter ? (
          <p className="mx-auto mb-8 max-w-xl rounded-lg border border-fiamma-coral/30 bg-fiamma-coral/10 px-4 py-3 text-center text-sm text-fiamma-text">
            Complimentary access remaining: <span className="font-semibold">{giftMeter.remaining}</span> of {giftMeter.total}
          </p>
        ) : null}

        {error ? <p className="mb-8 text-center text-red-600">{error}</p> : null}

        {books.length > 0 ? (
          <section className="mb-12">
            <div className="mb-6 flex items-end justify-between gap-4">
              <div>
                <p className="mb-2 text-sm font-semibold uppercase tracking-[0.24em] text-fiamma-coral">Featured</p>
                <h2 className="font-display text-3xl font-bold">Newest and most visible</h2>
              </div>
            </div>
            <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
              {books.slice(0, 3).map((book) => (
                <BookCard key={book.title_id} book={book} ctaLabel="Open book" />
              ))}
            </div>
          </section>
        ) : null}

        {books.some((book) => book.heteronym === 'Hailey Boone') ? (
          <section className="mb-12 rounded-3xl border border-gray-200 bg-white p-8 shadow-sm">
            <div className="mb-6 flex items-end justify-between gap-4">
              <div>
                <p className="mb-2 text-sm font-semibold uppercase tracking-[0.24em] text-fiamma-coral">Paradise Valley</p>
                <h2 className="font-display text-3xl font-bold">Hailey Boone series shelf</h2>
              </div>
            </div>
            <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
              {books
                .filter((book) => book.heteronym === 'Hailey Boone')
                .map((book) => (
                  <BookCard key={book.title_id} book={book} ctaLabel="Start reading" />
                ))}
            </div>
          </section>
        ) : null}

        <section>
          <div className="mb-6 flex items-end justify-between gap-4">
            <div>
              <p className="mb-2 text-sm font-semibold uppercase tracking-[0.24em] text-fiamma-coral">All titles</p>
              <h2 className="font-display text-3xl font-bold">Single shelf, imprint badges included</h2>
            </div>
          </div>
          <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
            {books.map((book) => (
              <BookCard key={book.title_id} book={book} />
            ))}
          </div>
        </section>
      </div>
    </main>
  )
}
