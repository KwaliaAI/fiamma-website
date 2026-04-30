import { useEffect, useMemo, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { BookCard } from '@/components/BookCard'
import { getImprintById } from '@/lib/fiammaBrand'
import { getVisibleBooks } from '@/lib/fiammaApi'
import { getHeteronymProfileBySlug, matchesHeteronymName } from '@/lib/heteronyms'
import type { FiammaBook } from '@/types/fiamma'

export function HeteronymPage() {
  const { slug = '' } = useParams()
  const profile = useMemo(() => getHeteronymProfileBySlug(slug), [slug])
  const [books, setBooks] = useState<FiammaBook[]>([])

  useEffect(() => {
    if (!profile) return

    let isActive = true
    getVisibleBooks()
      .then((visibleBooks) =>
        isActive && setBooks(visibleBooks.filter((book) => matchesHeteronymName(book.heteronym, profile.catalogName))),
      )
      .catch(() => {
        if (isActive) setBooks([])
      })

    return () => {
      isActive = false
    }
  }, [profile])

  const sortedBooks = useMemo(
    () =>
      [...books].sort((left, right) => {
        const leftOrder = left.series_order ?? Number.MAX_SAFE_INTEGER
        const rightOrder = right.series_order ?? Number.MAX_SAFE_INTEGER
        if (leftOrder !== rightOrder) return leftOrder - rightOrder
        return left.title.localeCompare(right.title)
      }),
    [books],
  )
  if (!profile) {
    return (
      <main className="section-padding pt-32 md:pt-40">
        <div className="mx-auto max-w-3xl text-center">
          <h1 className="mb-4 font-display text-4xl font-bold">Heteronym not found.</h1>
          <p className="mb-8 text-gray-600">This author profile is not available yet.</p>
          <Link
            to="/books"
            className="inline-block rounded-full bg-fiamma-coral px-6 py-3 font-semibold text-white transition-colors hover:bg-fiamma-dark"
          >
            Browse books
          </Link>
        </div>
      </main>
    )
  }

  const statusLabel = profile.status === 'active' ? 'Active' : 'Upcoming'
  const imprint = getImprintById(profile.imprintId)

  return (
    <main className="section-padding pt-32 md:pt-40">
      <div className="mx-auto max-w-6xl">
        <Link to="/heteronyms" className="mb-6 inline-block text-sm font-semibold text-fiamma-coral hover:text-fiamma-dark">
          Back to authors
        </Link>

        <section className="mb-14 grid gap-10 lg:grid-cols-[320px,1fr] lg:items-start">
          <div className="overflow-hidden rounded-3xl bg-white shadow-lg">
            <img src={profile.imagePath} alt={`${profile.name} portrait`} className="aspect-[3/4] w-full object-cover" />
          </div>

          <div>
            <p className="mb-3 text-sm font-semibold uppercase tracking-[0.28em] text-fiamma-coral">{statusLabel}</p>
            <h1 className="mb-4 font-display text-5xl font-bold text-fiamma-text md:text-6xl">{profile.name}</h1>
            <p className="mb-4 max-w-3xl text-lg leading-8 text-gray-700">{profile.seoDescription}</p>
            <p className="mb-4 max-w-3xl text-base leading-8 text-gray-700">{profile.bio}</p>
            {profile.longBio ? <p className="mb-6 max-w-3xl text-base leading-8 text-gray-700">{profile.longBio}</p> : null}
            <div className="flex flex-wrap items-center gap-3">
              <span className="rounded-full border border-fiamma-coral/30 bg-fiamma-coral/10 px-4 py-2 text-sm font-medium text-fiamma-text">
                {sortedBooks.length} visible title{sortedBooks.length === 1 ? '' : 's'}
              </span>
              {imprint ? (
                <Link
                  to={`/imprints/${imprint.slug}`}
                  className="rounded-full border border-fiamma-coral px-4 py-2 text-sm font-semibold text-fiamma-coral transition-colors hover:bg-fiamma-coral hover:text-white"
                >
                  {imprint.title}
                </Link>
              ) : null}
              <Link
                to="/heteronyms"
                className="rounded-full border border-gray-200 px-4 py-2 text-sm font-semibold text-gray-600 transition-colors hover:border-fiamma-coral hover:text-fiamma-coral"
              >
                Back to authors
              </Link>
              <Link
                to="/books"
                className="rounded-full border border-fiamma-coral px-4 py-2 text-sm font-semibold text-fiamma-coral transition-colors hover:bg-fiamma-coral hover:text-white"
              >
                View full catalog
              </Link>
            </div>

            {profile.seriesLine || profile.transparencyLine ? (
              <div className="mt-8 grid gap-4 md:grid-cols-2">
                {profile.seriesLine ? (
                  <div className="rounded-2xl border border-gray-200 bg-white p-5">
                    <p className="mb-2 text-xs font-semibold uppercase tracking-[0.2em] text-fiamma-coral">Series</p>
                    <p className="text-sm leading-7 text-gray-700">{profile.seriesLine}</p>
                  </div>
                ) : null}
                {profile.transparencyLine ? (
                  <div className="rounded-2xl border border-gray-200 bg-white p-5">
                    <p className="mb-2 text-xs font-semibold uppercase tracking-[0.2em] text-fiamma-coral">Transparency</p>
                    <p className="text-sm leading-7 text-gray-700">{profile.transparencyLine}</p>
                  </div>
                ) : null}
              </div>
            ) : null}
          </div>
        </section>

        <section>
          <div className="mb-8 flex flex-wrap items-end justify-between gap-4">
            <div>
              <p className="mb-2 text-sm font-semibold uppercase tracking-[0.24em] text-fiamma-coral">Books</p>
              <h2 className="font-display text-4xl font-bold text-fiamma-text">By {profile.name}</h2>
            </div>
          </div>

          {books.length === 0 ? (
            <div className="rounded-3xl border border-gray-200 bg-white p-8 text-center">
              <p className="text-gray-600">This heteronym does not have visible titles on the site yet.</p>
            </div>
          ) : (
            <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
              {sortedBooks.map((book) => (
                <BookCard key={book.title_id} book={book} />
              ))}
            </div>
          )}
        </section>
      </div>
    </main>
  )
}
