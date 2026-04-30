import { Link } from 'react-router-dom'
import { getBookImprint } from '@/lib/fiammaBrand'
import type { FiammaBook } from '@/types/fiamma'

type BookCardProps = {
  book: FiammaBook
  ctaLabel?: string
  ctaHref?: string
  progressLabel?: string | null
}

export function BookCard({ book, ctaLabel = 'Start reading', ctaHref, progressLabel = null }: BookCardProps) {
  const resolvedCtaHref = ctaHref ?? `/read/${book.slug}`
  const imprint = getBookImprint(book)

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
        <Link
          to={`/imprints/${imprint.slug}`}
          className="mb-3 inline-flex rounded-full border border-fiamma-coral/30 bg-fiamma-coral/10 px-3 py-1 text-[11px] font-semibold uppercase tracking-[0.2em] text-fiamma-coral"
        >
          {imprint.title}
        </Link>
        <h3 className="mb-2 font-display text-xl font-bold">{book.title}</h3>
        <p className="mb-1 text-sm text-gray-600">by {book.heteronym}</p>
        {progressLabel ? <p className="mb-1 text-xs font-semibold uppercase tracking-wide text-fiamma-coral">{progressLabel}</p> : null}
        <p className="mb-4 text-sm text-gray-600">{book.blurb_short ?? 'A story that will set your heart ablaze.'}</p>
        <div className="flex items-center justify-between gap-3">
          <span className="text-sm font-medium text-fiamma-coral">{book.fiamma_line ?? 'Fiamma'}</span>
          <Link
            to={resolvedCtaHref}
            className="rounded-full bg-fiamma-coral px-4 py-2 text-sm font-semibold text-white transition-colors hover:bg-fiamma-dark"
          >
            {ctaLabel}
          </Link>
        </div>
      </div>
    </article>
  )
}
