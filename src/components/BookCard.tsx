import { Link } from 'react-router-dom'
import type { FiammaBook } from '@/types/fiamma'

type BookCardProps = {
  book: FiammaBook
}

export function BookCard({ book }: BookCardProps) {
  return (
    <article className="book-card overflow-hidden rounded-2xl bg-white shadow-lg">
      <Link to={`/books/${book.slug}`} className="block" aria-label={`Open ${book.title}`}>
        {book.cover_url ? (
          <img src={book.cover_url} alt={book.title} className="aspect-[2/3] w-full object-cover" />
        ) : (
          <div className="flex aspect-[2/3] items-center justify-center bg-gradient-to-br from-fiamma-coral/20 to-fiamma-coral/40">
            <span className="text-lg font-medium text-fiamma-coral">Coming Soon</span>
          </div>
        )}
      </Link>
      <div className="p-6">
        <h3 className="mb-2 font-display text-xl font-bold">{book.title}</h3>
        <p className="mb-1 text-sm text-gray-600">by {book.heteronym}</p>
        <p className="mb-4 text-sm text-gray-600">{book.blurb_short ?? 'A story that will set your heart ablaze.'}</p>
        <div className="flex items-center justify-between gap-3">
          <span className="text-sm font-medium text-fiamma-coral">{book.fiamma_line ?? 'Fiamma'}</span>
          <Link
            to={`/read/${book.slug}`}
            className="rounded-full bg-fiamma-coral px-4 py-2 text-sm font-semibold text-white transition-colors hover:bg-fiamma-dark"
          >
            Start reading
          </Link>
        </div>
      </div>
    </article>
  )
}
