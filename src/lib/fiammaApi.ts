import type { FiammaBook, FiammaChapter } from '@/types/fiamma'
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
}

function withLocalCoverFallback(book: FiammaBook): FiammaBook {
  if (book.cover_url) return book
  const fallbackCover = localCoverFallbacks[book.slug]
  return fallbackCover ? { ...book, cover_url: fallbackCover } : book
}

async function fetchVisibleBooks(): Promise<FiammaBook[]> {
  if (!supabase) return placeholderBooks

  const { data, error } = await supabase
    .from('fiamma_books')
    .select('*')
    .eq('visible', true)
    .order('series_order', { ascending: true, nullsFirst: false })
    .order('created_at', { ascending: true })

  if (error) throw error
  return ((data as FiammaBook[]) ?? []).map(withLocalCoverFallback)
}

export async function getVisibleBooks(): Promise<FiammaBook[]> {
  if (!supabase) return placeholderBooks

  // Retry transient API/network issues before surfacing an error.
  for (let attempt = 0; attempt < 3; attempt += 1) {
    try {
      const books = await fetchVisibleBooks()
      return books.length > 0 ? books : placeholderBooks
    } catch (error) {
      if (attempt === 2) throw error
      await new Promise((resolve) => setTimeout(resolve, 350 * (attempt + 1)))
    }
  }

  return placeholderBooks
}

export async function getBookBySlug(slug: string): Promise<FiammaBook | null> {
  const placeholderMatch = placeholderBooks.find((book) => book.slug === slug) ?? null
  if (!supabase) return placeholderMatch

  const { data, error } = await supabase.from('fiamma_books').select('*').eq('slug', slug).maybeSingle()
  if (error) throw error
  const book = (data as FiammaBook | null) ?? placeholderMatch
  return book ? withLocalCoverFallback(book) : null
}

export async function getChaptersByBookId(bookId: string): Promise<FiammaChapter[]> {
  if (!supabase) return []

  const { data, error } = await supabase
    .from('fiamma_chapters')
    .select('*')
    .eq('book_id', bookId)
    .order('chapter_number', { ascending: true })

  if (error) throw error
  return (data as FiammaChapter[]) ?? []
}

export async function sendReaderAccess(email: string, slug: string, mode: ReaderMode): Promise<void> {
  if (!supabase) return

  const redirectUrl = `${appBaseUrl}/read/${slug}`
  const { error } = await supabase.auth.signInWithOtp({
    email,
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
  const { data } = await supabase.auth.getUser()
  const user = data.user
  if (!user) return

  const { error } = await supabase.from('fiamma_reader_profiles').upsert(
    [
      {
        user_id: user.id,
        email,
        last_seen: new Date().toISOString(),
      },
    ],
    { onConflict: 'user_id', ignoreDuplicates: false },
  )

  if (error) throw error
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
