import type { FiammaBook, FiammaChapter } from '@/types/fiamma'
import { normalizeHeteronymName } from '@/lib/heteronyms'
import { localFiammaBooks } from '@/lib/localFiammaBooks'
import { appBaseUrl, supabase } from '@/lib/supabase'

type ReaderMode = 'magic_link' | 'otp_code'
type GiftUnlockStatus = 'unlocked' | 'already_unlocked' | 'no_credits' | 'profile_missing'

type ClaimGiftUnlockResponse = {
  status: GiftUnlockStatus
  gift_credits_remaining: number
  gift_credits_total: number
}

export type ReaderGiftStatus = {
  isAuthenticated: boolean
  isUnlocked: boolean
  giftCreditsRemaining: number
  giftCreditsTotal: number
}

export type ReaderGiftBalance = {
  isAuthenticated: boolean
  giftCreditsRemaining: number
  giftCreditsTotal: number
}

export type ReaderShelfEntry = {
  book: FiammaBook
  lastChapter: number | null
  completed: boolean
  updatedAt: string | null
}

const placeholderBooks: FiammaBook[] = [
  {
    title_id: 'fiamma-fallback-1',
    title: 'New Fiamma Story Coming Soon',
    slug: 'coming-soon-1',
    heteronym: 'Fiamma Editorial',
    genre: 'Romance',
    fiamma_line: 'Fiamma Preview',
    blurb_short: 'Great stories are on the way. This shelf is warming up for your next obsession.',
    blurb_300: 'Great stories are on the way. This shelf is warming up for your next obsession.',
    cover_url: null,
    isbn_pb: null,
    isbn_eb: null,
    isbn_audio: null,
    buy_url_amazon: null,
    buy_url_ebook: null,
    buy_url_audio: null,
    series_order: 1,
    visible: true,
    created_at: new Date().toISOString(),
  },
  {
    title_id: 'fiamma-fallback-2',
    title: 'Your Next Romance Lands Here',
    slug: 'coming-soon-2',
    heteronym: 'Fiamma Editorial',
    genre: 'Romance',
    fiamma_line: 'Fiamma Preview',
    blurb_short: 'We are curating bold, unforgettable romance. Check back soon for your next read.',
    blurb_300: 'We are curating bold, unforgettable romance. Check back soon for your next read.',
    cover_url: null,
    isbn_pb: null,
    isbn_eb: null,
    isbn_audio: null,
    buy_url_amazon: null,
    buy_url_ebook: null,
    buy_url_audio: null,
    series_order: 2,
    visible: true,
    created_at: new Date().toISOString(),
  },
]

const localCoverFallbacks: Record<string, string> = {
  'terms-and-conditions': '/assets/covers/terms-and-conditions.jpg',
  'field-study': '/assets/covers/field-study.jpg',
  'base-notes': '/assets/covers/base-notes.jpg',
  'mud-season': '/assets/covers/mud-season.jpg',
}

type ChapterOverrideManifest = {
  generatedAt: string
  chapters: Array<{
    chapter_number: number
    chapter_title: string
    word_count: number | null
    path: string
  }>
}

const fallbackBooks = localFiammaBooks.length > 0 ? localFiammaBooks : placeholderBooks

function getFallbackBookBySlug(slug: string): FiammaBook | null {
  return fallbackBooks.find((book) => book.slug === slug) ?? null
}

function withBookNormalizations(book: FiammaBook): FiammaBook {
  const normalizedHeteronym = normalizeHeteronymName(book.heteronym)
  const normalizedBook = normalizedHeteronym === book.heteronym ? book : { ...book, heteronym: normalizedHeteronym }

  if (normalizedBook.cover_url) return normalizedBook
  const fallbackCover = localCoverFallbacks[normalizedBook.slug]
  return fallbackCover ? { ...normalizedBook, cover_url: fallbackCover } : normalizedBook
}

async function fetchChapterOverride(bookId: string): Promise<FiammaChapter[] | null> {
  const manifestPath = `/data/reader/${bookId}/manifest.json`

  try {
    const manifestResponse = await fetch(manifestPath)
    if (!manifestResponse.ok) return null

    const manifest = (await manifestResponse.json()) as ChapterOverrideManifest
    const chapters = await Promise.all(
      manifest.chapters.map(async (chapter) => {
        const chapterResponse = await fetch(chapter.path)
        if (!chapterResponse.ok) {
          throw new Error(`Failed to load chapter override ${chapter.path}`)
        }

        return {
          id: `${bookId}-${chapter.chapter_number}`,
          book_id: bookId,
          chapter_number: chapter.chapter_number,
          chapter_title: chapter.chapter_title,
          content_md: await chapterResponse.text(),
          word_count: chapter.word_count,
          created_at: manifest.generatedAt,
        } satisfies FiammaChapter
      }),
    )

    return chapters
  } catch (error) {
    console.warn('Chapter override fetch failed', {
      bookId,
      error: error instanceof Error ? error.message : String(error),
    })
    return null
  }
}

async function fetchVisibleBooks(): Promise<FiammaBook[]> {
  if (!supabase) return fallbackBooks

  const { data, error } = await supabase
    .from('fiamma_books')
    .select('*')
    .eq('visible', true)
    .order('series_order', { ascending: true, nullsFirst: false })
    .order('created_at', { ascending: true })

  if (error) throw error
  return ((data as FiammaBook[]) ?? []).map(withBookNormalizations)
}

export async function getVisibleBooks(): Promise<FiammaBook[]> {
  if (!supabase) return fallbackBooks

  // Retry transient API/network issues before surfacing an error.
  for (let attempt = 0; attempt < 3; attempt += 1) {
    try {
      const books = await fetchVisibleBooks()
      return books.length > 0 ? books : fallbackBooks
    } catch (error) {
      if (attempt === 2) {
        console.warn('Visible books fallback engaged', {
          error: error instanceof Error ? error.message : String(error),
        })
        return fallbackBooks
      }
      await new Promise((resolve) => setTimeout(resolve, 350 * (attempt + 1)))
    }
  }

  return fallbackBooks
}

export async function getBookBySlug(slug: string): Promise<FiammaBook | null> {
  const fallbackMatch = getFallbackBookBySlug(slug)
  if (!supabase) return fallbackMatch

  try {
    const { data, error } = await supabase.from('fiamma_books').select('*').eq('slug', slug).maybeSingle()
    if (error) throw error
    const book = (data as FiammaBook | null) ?? fallbackMatch
    return book ? withBookNormalizations(book) : null
  } catch (error) {
    console.warn('Book lookup fallback engaged', {
      slug,
      error: error instanceof Error ? error.message : String(error),
    })
    return fallbackMatch
  }
}

export async function getChaptersByBookId(bookId: string): Promise<FiammaChapter[]> {
  const override = await fetchChapterOverride(bookId)
  if (override) return override

  if (!supabase) return []

  try {
    const { data, error } = await supabase
      .from('fiamma_chapters')
      .select('*')
      .eq('book_id', bookId)
      .order('chapter_number', { ascending: true })

    if (error) throw error
    return (data as FiammaChapter[]) ?? []
  } catch (error) {
    console.warn('Chapter lookup fallback engaged', {
      bookId,
      error: error instanceof Error ? error.message : String(error),
    })
    return []
  }
}

export async function sendReaderAccess(email: string, slug: string, mode: ReaderMode): Promise<void> {
  if (!supabase) return

  const normalizedEmail = email.trim().toLowerCase()
  try {
    await supabase.rpc('fiamma_touch_reader_intake', { p_email: normalizedEmail, p_slug: slug, p_mode: mode })
  } catch {
    // Intake tracking must never block link delivery.
  }

  const redirectUrl = `${appBaseUrl}/read/${slug}`
  const { error } = await supabase.auth.signInWithOtp({
    email: normalizedEmail,
    options: {
      emailRedirectTo: redirectUrl,
      shouldCreateUser: true,
      data: {
        fiamma_mode: mode,
      },
    },
  })

  if (error) throw error
}

export async function verifyReaderOtp(email: string, token: string): Promise<void> {
  if (!supabase) return

  const { error } = await supabase.auth.verifyOtp({
    email,
    token,
    type: 'email',
  })

  if (error) throw error
}

export async function getReaderSession() {
  if (!supabase) return null
  const { data } = await supabase.auth.getSession()
  return data.session
}

export async function upsertReaderProfile(email: string): Promise<void> {
  if (!supabase) return
  const normalizedEmail = email.trim().toLowerCase()
  const { data: sessionData } = await supabase.auth.getSession()
  const accessToken = sessionData.session?.access_token ?? null

  if (accessToken) {
    try {
      const response = await fetch('/.netlify/functions/fiamma-reader-sync', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${accessToken}`,
        },
        body: JSON.stringify({
          email: normalizedEmail,
        }),
      })

      if (response.ok) return

      const body = await response.text().catch(() => '')
      console.warn('Fiamma reader sync failed', {
        status: response.status,
        body: body.slice(0, 300),
      })
    } catch (error) {
      console.warn('Fiamma reader sync transport error', {
        error: error instanceof Error ? error.message : String(error),
      })
    }
  }

  const { data } = await supabase.auth.getUser()
  const user = data.user
  if (!user) return

  const { error } = await supabase.from('fiamma_reader_profiles').upsert(
    [
      {
        user_id: user.id,
        email: normalizedEmail,
        last_seen: new Date().toISOString(),
      },
    ],
    { onConflict: 'user_id', ignoreDuplicates: false },
  )

  if (error) throw error

  try {
    await supabase.rpc('fiamma_touch_reader_profile', { p_email: normalizedEmail })
  } catch (rpcError) {
    console.warn('Fiamma reader activation sync failed', {
      email: normalizedEmail,
      error: rpcError instanceof Error ? rpcError.message : String(rpcError),
    })
  }
}

export async function getReaderProgressForBooks(
  bookIds: string[],
): Promise<Map<string, { lastChapter: number | null; completed: boolean; updatedAt: string | null }>> {
  const progressMap = new Map<string, { lastChapter: number | null; completed: boolean; updatedAt: string | null }>()

  if (!supabase || bookIds.length === 0) return progressMap

  const { data } = await supabase.auth.getUser()
  const user = data.user
  if (!user) return progressMap

  const { data: progressRows, error } = await supabase
    .from('fiamma_reading_progress')
    .select('book_id,last_chapter,completed,updated_at')
    .eq('user_id', user.id)
    .in('book_id', bookIds)

  if (error) throw error

  for (const row of (progressRows ?? []) as Array<{
    book_id: string
    last_chapter: number | null
    completed: boolean | null
    updated_at: string | null
  }>) {
    progressMap.set(row.book_id, {
      lastChapter: row.last_chapter ?? null,
      completed: Boolean(row.completed),
      updatedAt: row.updated_at ?? null,
    })
  }

  return progressMap
}

export async function getReaderGiftStatus(bookId: string): Promise<ReaderGiftStatus> {
  if (!supabase) {
    return {
      isAuthenticated: false,
      isUnlocked: false,
      giftCreditsRemaining: 0,
      giftCreditsTotal: 2,
    }
  }

  const { data } = await supabase.auth.getUser()
  const user = data.user
  if (!user) {
    return {
      isAuthenticated: false,
      isUnlocked: false,
      giftCreditsRemaining: 0,
      giftCreditsTotal: 2,
    }
  }

  const [{ data: profile }, { data: unlock }] = await Promise.all([
    supabase
      .from('fiamma_reader_profiles')
      .select('gift_credits_remaining,gift_credits_total')
      .eq('user_id', user.id)
      .maybeSingle(),
    supabase
      .from('fiamma_book_unlocks')
      .select('book_id')
      .eq('user_id', user.id)
      .eq('book_id', bookId)
      .maybeSingle(),
  ])

  return {
    isAuthenticated: true,
    isUnlocked: Boolean(unlock),
    giftCreditsRemaining: profile?.gift_credits_remaining ?? 2,
    giftCreditsTotal: profile?.gift_credits_total ?? 2,
  }
}

export async function getReaderGiftBalance(): Promise<ReaderGiftBalance> {
  if (!supabase) {
    return {
      isAuthenticated: false,
      giftCreditsRemaining: 0,
      giftCreditsTotal: 2,
    }
  }

  const { data } = await supabase.auth.getUser()
  const user = data.user
  if (!user) {
    return {
      isAuthenticated: false,
      giftCreditsRemaining: 0,
      giftCreditsTotal: 2,
    }
  }

  const { data: profile } = await supabase
    .from('fiamma_reader_profiles')
    .select('gift_credits_remaining,gift_credits_total')
    .eq('user_id', user.id)
    .maybeSingle()

  return {
    isAuthenticated: true,
    giftCreditsRemaining: profile?.gift_credits_remaining ?? 2,
    giftCreditsTotal: profile?.gift_credits_total ?? 2,
  }
}

export async function claimGiftUnlock(bookId: string): Promise<ClaimGiftUnlockResponse> {
  if (!supabase) {
    return {
      status: 'no_credits',
      gift_credits_remaining: 0,
      gift_credits_total: 2,
    }
  }

  const { data, error } = await supabase.rpc('fiamma_claim_gift_unlock', { p_book_id: bookId })
  if (error) throw error

  const result = (data as ClaimGiftUnlockResponse | null) ?? null
  if (!result) {
    return {
      status: 'profile_missing',
      gift_credits_remaining: 0,
      gift_credits_total: 2,
    }
  }
  return result
}

export async function upsertBookUnlock(bookId: string): Promise<void> {
  if (!supabase) return
  const { data } = await supabase.auth.getUser()
  const user = data.user
  if (!user) return

  const { error } = await supabase.from('fiamma_book_unlocks').upsert(
    [
      {
        user_id: user.id,
        book_id: bookId,
      },
    ],
    { onConflict: 'user_id,book_id', ignoreDuplicates: false },
  )

  if (error) throw error
}

export async function getSavedProgress(bookId: string): Promise<number | null> {
  if (!supabase) return null
  const { data } = await supabase.auth.getUser()
  const user = data.user
  if (!user) return null

  const { data: progress, error } = await supabase
    .from('fiamma_reading_progress')
    .select('last_chapter')
    .eq('user_id', user.id)
    .eq('book_id', bookId)
    .maybeSingle()

  if (error) return null
  return progress?.last_chapter ?? null
}

export async function getReaderShelfBooks(): Promise<FiammaBook[]> {
  if (!supabase) return []
  const { data } = await supabase.auth.getUser()
  const user = data.user
  if (!user) return []

  const { data: unlocks, error: unlocksError } = await supabase
    .from('fiamma_book_unlocks')
    .select('book_id')
    .eq('user_id', user.id)
    .order('unlocked_at', { ascending: false })

  if (unlocksError) throw unlocksError
  const bookIds = (unlocks ?? []).map((row) => row.book_id).filter(Boolean)
  if (bookIds.length === 0) return []

  const { data: books, error: booksError } = await supabase
    .from('fiamma_books')
    .select('*')
    .in('title_id', bookIds)
    .eq('visible', true)

  if (booksError) throw booksError

  const booksById = new Map((books as FiammaBook[]).map((book) => [book.title_id, book]))
  return bookIds.map((bookId) => booksById.get(bookId)).filter((book): book is FiammaBook => Boolean(book))
}

export async function getReaderShelfEntries(): Promise<ReaderShelfEntry[]> {
  if (!supabase) return []

  const { data } = await supabase.auth.getUser()
  const user = data.user
  if (!user) return []

  const { data: unlocks, error: unlocksError } = await supabase
    .from('fiamma_book_unlocks')
    .select('book_id, unlocked_at')
    .eq('user_id', user.id)
    .order('unlocked_at', { ascending: false })

  if (unlocksError) throw unlocksError

  const bookIds = (unlocks ?? []).map((row) => row.book_id).filter(Boolean)
  if (bookIds.length === 0) return []

  const [{ data: books, error: booksError }, progressMap] = await Promise.all([
    supabase
      .from('fiamma_books')
      .select('*')
      .in('title_id', bookIds)
      .eq('visible', true),
    getReaderProgressForBooks(bookIds),
  ])

  if (booksError) throw booksError

  const booksById = new Map((books as FiammaBook[]).map((book) => [book.title_id, book]))
  return bookIds
    .map((bookId) => {
      const book = booksById.get(bookId)
      if (!book) return null

      const progress = progressMap.get(bookId) ?? null
      return {
        book,
        lastChapter: progress?.lastChapter ?? null,
        completed: progress?.completed ?? false,
        updatedAt: progress?.updatedAt ?? null,
      } satisfies ReaderShelfEntry
    })
    .filter((entry): entry is ReaderShelfEntry => Boolean(entry))
}

export async function saveReaderProgress(bookId: string, chapter: number, completed = false): Promise<void> {
  if (!supabase) return
  const { data } = await supabase.auth.getUser()
  const user = data.user
  if (!user) return
  const timestamp = new Date().toISOString()

  const { error: progressError } = await supabase.from('fiamma_reading_progress').upsert(
    [
      {
        user_id: user.id,
        book_id: bookId,
        last_chapter: chapter,
        completed,
        updated_at: timestamp,
      },
    ],
    { onConflict: 'user_id,book_id', ignoreDuplicates: false },
  )
  if (progressError) throw progressError

  const email = user.email ?? null
  if (!email) return

  const { error: profileError } = await supabase.from('fiamma_reader_profiles').upsert(
    [
      {
        user_id: user.id,
        email,
        last_seen: timestamp,
      },
    ],
    { onConflict: 'user_id', ignoreDuplicates: false },
  )
  if (profileError) throw profileError
}
