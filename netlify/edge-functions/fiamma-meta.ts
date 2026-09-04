const DEFAULT_TITLE = 'Fiamma Books | Romance On Fire'
const DEFAULT_DESCRIPTION = 'Discover bold romance at Fiamma Books. Start with a complimentary read and build your shelf.'
const DEFAULT_OG_IMAGE = '/assets/fiamma-logo.png'

type BookMeta = {
  title: string
  description: string
  image: string
}

type PageMeta = {
  title: string
  description: string
  image?: string
}

const LEGACY_SEARCH_REDIRECTS: Array<{ key: string; value: string; path: string }> = [
  { key: 'page_id', value: '9', path: '/' },
  { key: 'page_id', value: '10', path: '/' },
  { key: 'page_id', value: '34', path: '/' },
  { key: 'feed', value: 'comments-rss2', path: '/' },
]

const HETERONYM_META: Record<string, PageMeta> = {
  'aubrey-kenneth-moss': {
    title: 'Aubrey Kenneth Moss — Fiamma Spark | Fiamma Books',
    description:
      'Aubrey Kenneth Moss writes high-heat, slow-burn romance for readers who like precision, pressure, and a payoff that lands hard.',
  },
  'hailey-boone': {
    title: 'Hailey Boone — Fiamma Contemporary | Fiamma Books',
    description:
      'Hailey Boone writes Montana ranch romance with heat, restraint, and real emotional stakes. Mud Season opens the Paradise Valley series.',
  },
  'seph-blackwood': {
    title: 'Seph Blackwood — Fiamma Fuoco | Fiamma Books',
    description:
      'Seph Blackwood writes dark, high-voltage romance for readers who want glamour, danger, and heat that does not apologize for itself.',
  },
  casey: {
    title: 'Casey Blake — Fiamma Contemporary | Fiamma Books',
    description:
      'Casey Blake writes college and professional sports romance with grit, momentum, and undeniable chemistry for Fiamma Contemporary.',
  },
}

const IMPRINT_META: Record<string, PageMeta> = {
  contemporary: {
    title: 'Fiamma Contemporary | Romance On Fire',
    description:
      'Stories for right now. No waiting, no permission, just the heat that happens when two people stop pretending they do not want it.',
  },
  spark: {
    title: 'Fiamma Spark | Romance On Fire',
    description:
      'The ache of the build. The tension that makes you want to scream at the characters to just do it already.',
  },
  fuoco: {
    title: 'Fiamma Fuoco | Romance On Fire',
    description:
      'Zero chill. For when you are done with the slow burn and just want the fire.',
  },
}

const LOCAL_BOOK_META: Record<string, BookMeta> = {
  'terms-and-conditions': {
    title: 'Terms and Conditions: A Novel | Fiamma Books',
    description:
      'A corporate attorney and a tech founder navigate the verifiable three inches between proof and promise.',
    image: '/assets/covers/terms-and-conditions.jpg',
  },
  'field-study': {
    title: 'Field Study | Fiamma Books',
    description:
      'A scientist applies field science discipline to the least tractable data problem she has ever encountered: a man she cannot classify.',
    image: '/assets/covers/field-study.jpg',
  },
  'base-notes': {
    title: 'Base Notes | Fiamma Books',
    description:
      'A perfumer with a flawless nose faces a commission, a debt, and the one base note she cannot identify.',
    image: '/assets/covers/base-notes.jpg',
  },
  'second-service': {
    title: 'Second Service | Fiamma Books',
    description:
      'Six days in Newport with the doubles partner she walked out on in 2011. Forty-one is too old to come back, which is why she said yes.',
    image: '/assets/covers/second-service.jpg',
  },
  'mud-season': {
    title: 'Mud Season | Fiamma Books',
    description:
      "Juniper McClaren flew to Montana to close an estate, not to fall in love with the man on the porch.",
    image: '/assets/covers/mud-season.jpg',
  },
  'heat-wave': {
    title: 'Heat Wave | Fiamma Books',
    description:
      'Deb Reeves came to Paradise Valley for six days of sun, beer, and water, not for the man across the county road.',
    image: '/assets/covers/heat-wave.jpg',
  },
  'bar-fight': {
    title: 'Bar Fight | Fiamma Books',
    description:
      "Molly Henderson came to Paradise Valley to sell her uncle's cabin and drive back to her bar in Livingston by Saturday night.",
    image: '/assets/covers/bar-fight.jpg',
  },
  'cold-snap': {
    title: 'Cold Snap | Fiamma Books',
    description:
      "Robin McKee's mail truck is in a ditch, and a retired rodeo cowboy is about to become her warmest problem.",
    image: '/assets/covers/cold-snap.jpg',
  },
  'wrong-side-of-the-ice': {
    title: 'Wrong Side of the Ice | Fiamma Books',
    description:
      'Nora Voss is supposed to clear Gabe Cahill for the semifinal, not fall for the transfer winger whose ankle she knows better than her own pulse.',
    image: '/assets/covers/wrong-side-of-the-ice.jpg',
  },
  'extra-time': {
    title: 'Extra Time | Fiamma Books',
    description:
      "Tess Brennan flew to the World Cup to write Mexico's host-nation run, not to share a one-bedroom Airbnb with the ex-Atlas star turned broadcaster.",
    image: '/assets/covers/extra-time.jpg',
  },
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
  const localMeta = LOCAL_BOOK_META[slug] ?? null
  const supabaseUrl = Deno.env.get('VITE_SUPABASE_URL') ?? Deno.env.get('SUPABASE_URL')
  const supabaseAnonKey = Deno.env.get('VITE_SUPABASE_ANON_KEY') ?? Deno.env.get('SUPABASE_ANON_KEY')
  if (!supabaseUrl || !supabaseAnonKey) return localMeta

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
    if (!response.ok) return localMeta
    const books = (await response.json()) as Array<{ title?: string; blurb_short?: string | null; cover_url?: string | null }>
    const book = books[0]
    if (!book?.title) return localMeta

    return {
      title: `${book.title} | Fiamma Books`,
      description: book.blurb_short?.trim() || localMeta?.description || DEFAULT_DESCRIPTION,
      image: localMeta?.image || book.cover_url || DEFAULT_OG_IMAGE,
    }
  } catch {
    return localMeta
  }
}

function getLegacyRedirectPath(url: URL): string | null {
  if (url.pathname !== '/') return null
  for (const redirect of LEGACY_SEARCH_REDIRECTS) {
    if (url.searchParams.get(redirect.key) === redirect.value) return redirect.path
  }
  return null
}

function getRouteMeta(url: URL): PageMeta | null {
  const segments = url.pathname.split('/').filter(Boolean)
  if (segments[0] === 'books' && segments.length === 1) {
    return {
      title: 'Fiamma Books Catalog | Romance On Fire',
      description: 'Browse Fiamma Books romance titles and start a complimentary read from the catalog.',
    }
  }

  if (segments[0] === 'heteronyms' && segments.length === 2) {
    return HETERONYM_META[segments[1]] ?? {
      title: 'Fiamma Authors | Romance On Fire',
      description: 'Meet the Fiamma heteronyms and explore the books behind each voice.',
    }
  }

  if (segments[0] === 'imprints' && segments.length === 1) {
    return {
      title: 'Fiamma Imprints | Romance On Fire',
      description: 'Find the Fiamma lane that fits your reading mood across Contemporary, Spark, and Fuoco.',
    }
  }

  if (segments[0] === 'imprints' && segments.length === 2) {
    return IMPRINT_META[segments[1]] ?? {
      title: 'Fiamma Imprints | Romance On Fire',
      description: 'Find the Fiamma lane that fits your reading mood across Contemporary, Spark, and Fuoco.',
    }
  }

  if (segments[0] === 'heteronyms' && segments.length === 1) {
    return {
      title: 'Fiamma Authors | Romance On Fire',
      description: 'Meet the Fiamma heteronyms and explore the books behind each voice.',
    }
  }

  if (segments.length === 1 && segments[0] === 'privacy') {
    return {
      title: 'Privacy Policy | Fiamma Books',
      description: 'Read the Fiamma Books privacy policy for reader accounts, email subscriptions, analytics, and support.',
    }
  }

  if (segments.length === 1 && segments[0] === 'terms') {
    return {
      title: 'Terms of Service | Fiamma Books',
      description: 'Read the Fiamma Books terms for reader accounts, complimentary access, purchases, and site use.',
    }
  }

  return null
}

export default async (request: Request, context: { next: () => Promise<Response> }) => {
  const url = new URL(request.url)
  const legacyRedirectPath = getLegacyRedirectPath(url)
  if (legacyRedirectPath) {
    return Response.redirect(`${url.origin}${legacyRedirectPath}`, 301)
  }

  const segments = url.pathname.split('/').filter(Boolean)
  const slug = segments.length >= 2 ? segments[1] : null
  const isReaderSurface = url.pathname.startsWith('/read/')
  const isShelf = url.pathname === '/shelf'
  const isInternalUtility = url.pathname === '/editorial' || url.pathname.startsWith('/tiktok/callback')
  const robotsValue = isReaderSurface || isShelf || isInternalUtility ? 'noindex, nofollow' : 'index, follow, max-image-preview:large'

  const response = await context.next()
  const contentType = response.headers.get('content-type') ?? ''
  if (!contentType.includes('text/html')) return response

  const html = await response.text()
  const bookMeta = slug ? await getBookMeta(slug) : null
  const routeMeta = getRouteMeta(url)
  const title = escapeHtml(routeMeta?.title || bookMeta?.title || DEFAULT_TITLE)
  const description = escapeHtml(routeMeta?.description || bookMeta?.description || DEFAULT_DESCRIPTION)
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
