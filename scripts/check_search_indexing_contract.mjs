#!/usr/bin/env node
import { readFileSync } from 'node:fs'
import { resolve } from 'node:path'

const root = process.cwd()
const sitemapPath = resolve(root, 'public/sitemap.xml')
const edgePath = resolve(root, 'netlify/edge-functions/fiamma-meta.ts')

const sitemap = readFileSync(sitemapPath, 'utf8')
const edgeFunction = readFileSync(edgePath, 'utf8')

const errors = []
const urls = [...sitemap.matchAll(/<loc>([^<]+)<\/loc>/g)].map((match) => match[1])
const requiredSitemapUrls = [
  'https://fiammabooks.com/',
  'https://fiammabooks.com/books',
  'https://fiammabooks.com/books/terms-and-conditions',
  'https://fiammabooks.com/books/field-study',
  'https://fiammabooks.com/books/base-notes',
  'https://fiammabooks.com/books/mud-season',
  'https://fiammabooks.com/books/heat-wave',
  'https://fiammabooks.com/books/bar-fight',
  'https://fiammabooks.com/heteronyms',
  'https://fiammabooks.com/heteronyms/aubrey-kenneth-moss',
  'https://fiammabooks.com/heteronyms/hailey-boone',
]

if (urls.length === 0) {
  errors.push('public/sitemap.xml has no <loc> entries')
}

if (new Set(urls).size !== urls.length) {
  errors.push('public/sitemap.xml contains duplicate <loc> entries')
}

for (const requiredUrl of requiredSitemapUrls) {
  if (!urls.includes(requiredUrl)) {
    errors.push(`missing required sitemap URL: ${requiredUrl}`)
  }
}

for (const url of urls) {
  if (!url.startsWith('https://fiammabooks.com/')) {
    errors.push(`sitemap URL is outside canonical host: ${url}`)
  }
  if (url.includes('?') || url.includes('#')) {
    errors.push(`sitemap URL must be query-free and fragment-free: ${url}`)
  }
  if (url.includes('/read/') || url.endsWith('/shelf')) {
    errors.push(`sitemap URL points to noindex surface: ${url}`)
  }
}

const requiredLegacyRedirects = [
  "key: 'page_id', value: '9'",
  "key: 'page_id', value: '10'",
  "key: 'page_id', value: '34'",
  "key: 'feed', value: 'comments-rss2'",
]

for (const needle of requiredLegacyRedirects) {
  if (!edgeFunction.includes(needle)) {
    errors.push(`missing legacy Search Console redirect contract: ${needle}`)
  }
}

if (!edgeFunction.includes('Response.redirect(`${url.origin}${legacyRedirectPath}`, 301)')) {
  errors.push('legacy Search Console redirects must use a 301 response')
}

if (errors.length > 0) {
  console.error('[search-indexing] FAILED')
  for (const error of errors) console.error(`- ${error}`)
  process.exit(1)
}

console.log(
  `[search-indexing] OK (${urls.length} sitemap URL(s), ${requiredSitemapUrls.length} required, ${requiredLegacyRedirects.length} legacy redirect pattern(s))`,
)
