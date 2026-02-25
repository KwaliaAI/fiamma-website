const TOKEN_KEY = 'fiamma_reader_token'

const positionKey = (slug: string) => `fiamma_position_${slug}`

export const getReaderToken = () => localStorage.getItem(TOKEN_KEY)
export const setReaderToken = (email: string) => localStorage.setItem(TOKEN_KEY, email)
export const clearReaderToken = () => localStorage.removeItem(TOKEN_KEY)

export const getPosition = (slug: string) => {
  const raw = localStorage.getItem(positionKey(slug))
  const parsed = Number.parseInt(raw ?? '1', 10)
  return Number.isNaN(parsed) || parsed < 1 ? 1 : parsed
}

export const savePosition = (slug: string, chapter: number) => {
  localStorage.setItem(positionKey(slug), String(chapter))
}
