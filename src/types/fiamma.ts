export type FiammaBook = {
  title_id: string
  title: string
  slug: string
  heteronym: string
  genre: string
  fiamma_line: string | null
  blurb_short: string | null
  blurb_300: string | null
  cover_url: string | null
  isbn_pb: string | null
  isbn_eb: string | null
  isbn_audio: string | null
  buy_url_amazon: string | null
  buy_url_ebook: string | null
  buy_url_audio: string | null
  series_order: number | null
  visible: boolean
  created_at: string
  updated_at?: string
}

export type FiammaChapter = {
  id: string
  book_id: string
  chapter_number: number
  chapter_title: string | null
  content_md: string
  word_count: number | null
  created_at: string
}
