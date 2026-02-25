import { useEffect, useState } from 'react'
import { Link, Navigate } from 'react-router-dom'
import { BookCard } from '@/components/BookCard'
import { getReaderGiftBalance, getReaderSession, getReaderShelfBooks } from '@/lib/fiammaApi'
import type { FiammaBook } from '@/types/fiamma'

export function ShelfPage() {
  const [loading, setLoading] = useState(true)
  const [isAuthenticated, setIsAuthenticated] = useState(false)
  const [books, setBooks] = useState<FiammaBook[]>([])
  const [error, setError] = useState<string | null>(null)
  const [giftMeter, setGiftMeter] = useState<{ remaining: number; total: number } | null>(null)

  useEffect(() => {
    let isActive = true

    const run = async () => {
      try {
        const session = await getReaderSession()
        if (!isActive) return
        if (!session?.user) {
          setIsAuthenticated(false)
          return
        }

        setIsAuthenticated(true)
        const [shelfBooks, balance] = await Promise.all([getReaderShelfBooks(), getReaderGiftBalance()])
        if (!isActive) return
        setBooks(shelfBooks)
        if (balance.isAuthenticated) {
          setGiftMeter({ remaining: balance.giftCreditsRemaining, total: balance.giftCreditsTotal })
        }
      } catch {
        if (!isActive) return
        setError('Could not load your shelf right now.')
      } finally {
        if (isActive) setLoading(false)
      }
    }

    void run()
    return () => {
      isActive = false
    }
  }, [])

  if (loading) {
    return (
      <main className="section-padding pt-32 md:pt-40">
        <p className="text-center text-gray-600">Loading your shelf...</p>
      </main>
    )
  }

  if (!isAuthenticated) {
    return <Navigate to="/books" replace />
  }

  return (
    <main className="section-padding pt-32 md:pt-40">
      <div className="mx-auto max-w-6xl">
        <h1 className="mb-4 text-center font-display text-5xl font-bold">My Shelf</h1>
        <p className="mx-auto mb-12 max-w-2xl text-center text-gray-600">
          Your unlocked books appear here. Open any title and continue reading where you left off.
        </p>

        {giftMeter ? (
          <p className="mx-auto mb-8 max-w-xl rounded-lg border border-fiamma-coral/30 bg-fiamma-coral/10 px-4 py-3 text-center text-sm text-fiamma-text">
            Complimentary reads remaining: <span className="font-semibold">{giftMeter.remaining}</span> of {giftMeter.total}
          </p>
        ) : null}

        {error ? <p className="mb-8 text-center text-red-600">{error}</p> : null}

        {!error && books.length === 0 ? (
          <div className="mx-auto max-w-xl rounded-2xl border border-gray-200 bg-white p-8 text-center">
            <p className="mb-4 text-gray-700">Your shelf is empty.</p>
            <Link
              to="/books"
              className="inline-block rounded-full bg-fiamma-coral px-6 py-3 font-semibold text-white transition-colors hover:bg-fiamma-dark"
            >
              Explore Books
            </Link>
          </div>
        ) : null}

        {books.length > 0 ? (
          <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
            {books.map((book) => (
              <BookCard key={book.title_id} book={book} />
            ))}
          </div>
        ) : null}
      </div>
    </main>
  )
}
