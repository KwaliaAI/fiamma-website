import { useEffect, useState } from 'react'
import { BookCard } from '@/components/BookCard'
import { getReaderGiftBalance, getVisibleBooks } from '@/lib/fiammaApi'
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
          The first book is our gift to you. Everything after is Fiamma Membership — from £4.99/month.
        </p>

        {giftMeter ? (
          <p className="mx-auto mb-8 max-w-xl rounded-lg border border-fiamma-coral/30 bg-fiamma-coral/10 px-4 py-3 text-center text-sm text-fiamma-text">
            Complimentary access remaining: <span className="font-semibold">{giftMeter.remaining}</span> of {giftMeter.total}
          </p>
        ) : null}

        {error ? <p className="mb-8 text-center text-red-600">{error}</p> : null}

        <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
          {books.map((book) => (
            <BookCard key={book.title_id} book={book} />
          ))}
        </div>
      </div>
    </main>
  )
}
