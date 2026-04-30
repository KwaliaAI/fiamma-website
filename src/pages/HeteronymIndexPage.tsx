import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { HeteronymCard } from '@/components/HeteronymCard'
import { getVisibleBooks } from '@/lib/fiammaApi'
import { heteronymProfiles } from '@/lib/heteronyms'
import type { FiammaBook } from '@/types/fiamma'

export function HeteronymIndexPage() {
  const [books, setBooks] = useState<FiammaBook[]>([])

  useEffect(() => {
    getVisibleBooks().then(setBooks).catch(() => setBooks([]))
  }, [])

  return (
    <main className="section-padding pt-32 md:pt-40">
      <div className="mx-auto max-w-6xl">
        <div className="mx-auto mb-12 max-w-3xl text-center">
          <p className="mb-3 text-sm font-semibold uppercase tracking-[0.28em] text-fiamma-coral">Authors</p>
          <h1 className="mb-4 font-display text-5xl font-bold">Meet the Fiamma voices</h1>
          <p className="text-lg leading-8 text-gray-700">
            Each heteronym has its own page, its own books, and its own place in the brand. Use these pages as the public
            landing points for readers, socials, and search.
          </p>
        </div>

        <div className="mb-8 flex flex-wrap items-center justify-between gap-4">
          <p className="text-sm text-gray-500">
            Current visible titles: <span className="font-semibold text-fiamma-text">{books.length}</span>
          </p>
          <Link to="/books" className="text-sm font-semibold text-fiamma-coral underline-offset-4 hover:underline">
            Browse books
          </Link>
        </div>

        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {heteronymProfiles.map((heteronym) => (
            <HeteronymCard key={heteronym.slug} {...heteronym} />
          ))}
        </div>
      </div>
    </main>
  )
}

