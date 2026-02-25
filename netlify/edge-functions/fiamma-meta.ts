const DEFAULT_TITLE = 'Fiamma Books | Romance On Fire'
const DEFAULT_DESCRIPTION = 'Discover bold romance at Fiamma Books. Unlock your first two complimentary reads and build your shelf.'
const DEFAULT_OG_IMAGE = '/assets/fiamma-logo.png'

type BookMeta = {
  title: string
  description: string
  image: string
}

function escapeHtml(value: string): string {
  return value
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#39;')
}

function updateTag(html: string, matcher: RegExp, replacement: string): string {
  if (matcher.test(html)) return html.replace(matcher, replacement)
  return html
}

async function getBookMeta(slug: string): Promise<BookMeta | null> {
  const supabaseUrl = Deno.env.get('VITE_SUPABASE_URL') ?? Deno.env.get('SUPABASE_URL')
  const supabaseAnonKey = Deno.env.get('VITE_SUPABASE_ANON_KEY') ?? Deno.env.get('SUPABASE_ANON_KEY')
  if (!supabaseUrl || !supabaseAnonKey) return null

  const endpoint =
    `${supabaseUrl}/rest/v1/fiamma_books` +
    `?select=title,blurb_short,cover_url` +
    `&slug=eq.${encodeURIComponent(slug)}` +
    `&limit=1`

  try {
    const response = await fetch(endpoint, {
      headers: {
        apikey: supabaseAnonKey,
        Authorization: `Bearer ${supabaseAnonKey}`,
      },
    })
    if (!response.ok) return null
    const books = (await response.json()) as Array<{ title?: string; blurb_short?: string | null; cover_url?: string | null }>
    const book = books[0]
    if (!book?.title) return null

    return {
      title: `${book.title} | Fiamma Books`,
      description: book.blurb_short?.trim() || DEFAULT_DESCRIPTION,
      image: book.cover_url || DEFAULT_OG_IMAGE,
    }
  } catch {
    return null
  }
}

export default async (request: Request, context: { next: () => Promise<Response> }) => {
  const url = new URL(request.url)
  const segments = url.pathname.split('/').filter(Boolean)
  const slug = segments.length >= 2 ? segments[1] : null
  const isReaderSurface = url.pathname.startsWith('/read/')
  const isShelf = url.pathname === '/shelf'
  const robotsValue = isReaderSurface || isShelf ? 'noindex, nofollow' : 'index, follow, max-image-preview:large'

  const response = await context.next()
  const contentType = response.headers.get('content-type') ?? ''
  if (!contentType.includes('text/html')) return response

  const html = await response.text()
  const bookMeta = slug ? await getBookMeta(slug) : null
  const title = escapeHtml(bookMeta?.title || DEFAULT_TITLE)
  const description = escapeHtml(bookMeta?.description || DEFAULT_DESCRIPTION)
  const imageUrl = new URL(bookMeta?.image || DEFAULT_OG_IMAGE, url.origin).toString()
  const escapedImageUrl = escapeHtml(imageUrl)
  const canonicalUrl = `${url.origin}${url.pathname}`
  const escapedCanonical = escapeHtml(canonicalUrl)

  let updated = html
  updated = updateTag(updated, /<title>[\s\S]*?<\/title>/i, `<title>${title}</title>`)
  updated = updateTag(updated, /<meta\s+name=["']description["'][^>]*>/i, `<meta name="description" content="${description}" />`)
  updated = updateTag(updated, /<meta\s+property=["']og:title["'][^>]*>/i, `<meta property="og:title" content="${title}" />`)
  updated = updateTag(updated, /<meta\s+property=["']og:description["'][^>]*>/i, `<meta property="og:description" content="${description}" />`)
  updated = updateTag(updated, /<meta\s+property=["']og:image["'][^>]*>/i, `<meta property="og:image" content="${escapedImageUrl}" />`)
  updated = updateTag(updated, /<meta\s+property=["']og:url["'][^>]*>/i, `<meta property="og:url" content="${escapedCanonical}" />`)
  updated = updateTag(updated, /<meta\s+name=["']robots["'][^>]*>/i, `<meta name="robots" content="${robotsValue}" />`)
  updated = updateTag(updated, /<meta\s+name=["']twitter:title["'][^>]*>/i, `<meta name="twitter:title" content="${title}" />`)
  updated = updateTag(
    updated,
    /<meta\s+name=["']twitter:description["'][^>]*>/i,
    `<meta name="twitter:description" content="${description}" />`,
  )
  updated = updateTag(updated, /<meta\s+name=["']twitter:image["'][^>]*>/i, `<meta name="twitter:image" content="${escapedImageUrl}" />`)
  updated = updateTag(updated, /<link\s+rel=["']canonical["'][^>]*>/i, `<link rel="canonical" href="${escapedCanonical}" />`)

  const headers = new Headers(response.headers)
  headers.set('x-robots-tag', robotsValue)

  return new Response(updated, {
    status: response.status,
    statusText: response.statusText,
    headers,
  })
}
