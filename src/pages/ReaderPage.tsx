import { useEffect, useMemo, useState } from 'react'
import { Link, useNavigate, useParams } from 'react-router-dom'
import {
  getBookBySlug,
  getChaptersByBookId,
  getReaderSession,
  getSavedProgress,
  getVisibleBooks,
  saveReaderProgress,
  upsertBookUnlock,
} from '@/lib/fiammaApi'
import { getPosition, savePosition } from '@/lib/readerGate'
import type { FiammaBook, FiammaChapter } from '@/types/fiamma'

export function ReaderPage() {
  const { slug = '', chapter = '1' } = useParams()
  const navigate = useNavigate()

  const [book, setBook] = useState<FiammaBook | null>(null)
  const [chapters, setChapters] = useState<FiammaChapter[]>([])
  const [otherBooks, setOtherBooks] = useState<FiammaBook[]>([])

  useEffect(() => {
    getReaderSession().then((session) => {
      if (!session?.user) {
        navigate(`/read/${slug}`, { replace: true })
      }
    })
  }, [navigate, slug])

  useEffect(() => {
    getBookBySlug(slug).then(async (resolvedBook) => {
      setBook(resolvedBook)
      if (!resolvedBook) return

      await upsertBookUnlock(resolvedBook.title_id)

      getChaptersByBookId(resolvedBook.title_id).then((resolvedChapters) => {
        setChapters(resolvedChapters)
      })

      getVisibleBooks().then((books) => {
        setOtherBooks(books.filter((candidate) => candidate.slug !== slug))
      })
    })
  }, [slug])

  const chapterNumber = Number.parseInt(chapter, 10)
  const safeChapter = Number.isNaN(chapterNumber) || chapterNumber < 1 ? 1 : chapterNumber
  const totalChapters = chapters.length

  const currentChapter = useMemo(
    () => chapters.find((item) => item.chapter_number === safeChapter) ?? null,
    [chapters, safeChapter],
  )

  useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'auto' })
  }, [slug, safeChapter])

  useEffect(() => {
    if (!book || totalChapters === 0) return

    getSavedProgress(book.title_id).then((savedFromDb) => {
      const localFallback = getPosition(slug)
      const candidate = savedFromDb && savedFromDb > 0 ? savedFromDb : localFallback
      if (safeChapter === 1 && candidate > 1 && candidate <= totalChapters) {
        navigate(`/read/${slug}/${candidate}`, { replace: true })
      }
    })
  }, [book, navigate, safeChapter, slug, totalChapters])

  useEffect(() => {
    if (!book || totalChapters === 0) return

    if (safeChapter <= totalChapters) {
      savePosition(slug, safeChapter)
      saveReaderProgress(book.title_id, safeChapter, false).catch(() => undefined)
      return
    }

    const finalChapter = totalChapters
    savePosition(slug, finalChapter)
    saveReaderProgress(book.title_id, finalChapter, true).catch(() => undefined)
  }, [book, safeChapter, slug, totalChapters])

  if (!book) {
    return (
      <main className="section-padding pt-32 md:pt-40">
        <p className="text-center text-gray-600">This title is not available in the reader yet.</p>
      </main>
    )
  }

  if (totalChapters === 0) {
    return (
      <main className="section-padding pt-32 md:pt-40">
        <p className="text-center text-gray-600">Chapters are coming soon.</p>
      </main>
    )
  }

  const progress = Math.min((Math.min(safeChapter, totalChapters) / totalChapters) * 100, 100)
  const isEndScreen = safeChapter > totalChapters

  if (isEndScreen) {
    return (
      <main className="section-padding pt-32 md:pt-40">
        <div className="mx-auto max-w-3xl text-center">
          <h1 className="mb-4 font-display text-5xl font-bold">The End.</h1>
          <p className="mb-8 text-gray-700">That&apos;s {book.title} by {book.heteronym}.</p>

          <h2 className="mb-4 font-display text-2xl font-bold">Also by {book.heteronym}</h2>
          <div className="mb-10 flex flex-wrap justify-center gap-3">
            {otherBooks.length === 0 ? (
              <p className="text-gray-600">More titles coming soon.</p>
            ) : (
              otherBooks.map((related) => (
                <Link
                  key={related.title_id}
                  to={`/books/${related.slug}`}
                  className="rounded-full border border-fiamma-coral px-4 py-2 text-sm font-semibold text-fiamma-coral hover:bg-fiamma-coral hover:text-white"
                >
                  {related.title}
                </Link>
              ))
            )}
          </div>

          <h2 className="mb-4 font-display text-2xl font-bold">Own it</h2>
          <div className="flex flex-wrap justify-center gap-3">
            {book.buy_url_amazon ? (
              <a
                href={book.buy_url_amazon}
                target="_blank"
                rel="noreferrer"
                className="rounded-full bg-fiamma-coral px-5 py-2 text-sm font-semibold text-white hover:bg-fiamma-dark"
              >
                Amazon PB
              </a>
            ) : null}
            {book.buy_url_ebook ? (
              <a
                href={book.buy_url_ebook}
                target="_blank"
                rel="noreferrer"
                className="rounded-full bg-fiamma-coral px-5 py-2 text-sm font-semibold text-white hover:bg-fiamma-dark"
              >
                Ebook
              </a>
            ) : null}
            {book.buy_url_audio ? (
              <a
                href={book.buy_url_audio}
                target="_blank"
                rel="noreferrer"
                className="rounded-full bg-fiamma-coral px-5 py-2 text-sm font-semibold text-white hover:bg-fiamma-dark"
              >
                Audio
              </a>
            ) : null}
          </div>
        </div>
      </main>
    )
  }

  return (
    <main className="pb-28 pt-20 md:pt-24">
      <div className="fixed left-0 right-0 top-[72px] z-40 h-1 bg-gray-200">
        <div className="h-full bg-fiamma-coral" style={{ width: `${progress}%` }} />
      </div>

      <article className="mx-auto max-w-[65ch] px-4 pt-14 md:px-6">
        <p className="mb-3 text-sm font-semibold uppercase tracking-wide text-fiamma-coral">{book.title}</p>
        <h1 className="mb-8 font-display text-4xl font-bold md:text-5xl">
          {currentChapter?.chapter_title ?? `Chapter ${safeChapter}`}
        </h1>
        <div
          className="whitespace-pre-wrap text-[16px] leading-[1.85] text-gray-800 md:text-[17px]"
          style={{ fontFamily: 'Georgia, serif' }}
        >
          {currentChapter?.content_md ?? 'Chapter content unavailable.'}
        </div>
      </article>

      <div className="fixed bottom-0 left-0 right-0 border-t border-gray-200 bg-fiamma-bg/95 px-4 py-3 backdrop-blur-sm">
        <div className="mx-auto flex max-w-5xl items-center justify-between gap-4">
          <button
            type="button"
            onClick={() => navigate(`/read/${slug}/${Math.max(1, safeChapter - 1)}`)}
            disabled={safeChapter <= 1}
            className="rounded-full border border-fiamma-coral px-4 py-2 text-sm font-semibold text-fiamma-coral disabled:cursor-not-allowed disabled:opacity-40"
          >
            Previous
          </button>

          <p className="text-sm font-medium text-gray-700">
            Chapter {safeChapter} of {totalChapters}
          </p>

          <button
            type="button"
            onClick={() => navigate(`/read/${slug}/${safeChapter + 1}`)}
            className="rounded-full bg-fiamma-coral px-4 py-2 text-sm font-semibold text-white hover:bg-fiamma-dark"
          >
            Next
          </button>
        </div>
      </div>
    </main>
  )
}
