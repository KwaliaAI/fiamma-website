#!/usr/bin/env node

import { cpSync, existsSync, mkdirSync, readdirSync, readFileSync, rmSync } from 'node:fs'
import { execFileSync } from 'node:child_process'
import { basename, dirname, join, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'

const scriptDir = dirname(fileURLToPath(import.meta.url))
const rootDir = resolve(scriptDir, '..')
const sourceDir = resolve(rootDir, process.env.GOOGLE_PLAY_FETCH_SOURCE ?? '../catalog/out/google_play/fetch')
const targetDir = resolve(rootDir, process.env.GOOGLE_PLAY_FETCH_TARGET ?? 'public/google-play/fetch')

function listFullOnixFeeds(fetchRoot) {
  const onixDir = join(fetchRoot, 'onix')
  if (!existsSync(onixDir)) return []

  return readdirSync(onixDir, { withFileTypes: true })
    .filter((entry) => entry.isDirectory() && entry.name.endsWith('-full'))
    .flatMap((entry) => {
      const dir = join(onixDir, entry.name)
      return readdirSync(dir, { withFileTypes: true })
        .filter((file) => file.isFile() && file.name.endsWith('.xml'))
        .map((file) => ({
          collection: entry.name.replace(/-full$/, ''),
          path: join(dir, file.name),
        }))
    })
}

function extractProductIsbns(onixPath) {
  const xml = readFileSync(onixPath, 'utf8')
  const products = xml.match(/<Product\b[\s\S]*?<\/Product>/g) ?? []
  const isbns = []

  for (const product of products) {
    const idMatch = product.match(
      /<ProductIdentifier>\s*<ProductIDType>15<\/ProductIDType>\s*<IDValue>([0-9Xx-]+)<\/IDValue>\s*<\/ProductIdentifier>/,
    )
    if (idMatch?.[1]) {
      isbns.push(idMatch[1].replace(/[^0-9Xx]/g, ''))
    }
  }

  return isbns
}

function validateFetchTree(fetchRoot) {
  const missing = []

  for (const feed of listFullOnixFeeds(fetchRoot)) {
    const assetDir = join(fetchRoot, 'ebooks', feed.collection)
    for (const isbn of extractProductIsbns(feed.path)) {
      for (const ext of ['epub', 'jpg']) {
        const assetPath = join(assetDir, `${isbn}.${ext}`)
        if (!existsSync(assetPath)) {
          missing.push(`${feed.collection}: ${basename(feed.path)} advertises ${isbn}.${ext}, but ${assetPath} is missing`)
        }
      }
    }
  }

  if (missing.length > 0) {
    throw new Error(`Google Play fetch tree is inconsistent:\n- ${missing.join('\n- ')}`)
  }
}

if (!existsSync(sourceDir)) {
  throw new Error(`Google Play fetch source not found: ${sourceDir}`)
}

mkdirSync(dirname(targetDir), { recursive: true })
rmSync(targetDir, { recursive: true, force: true })
cpSync(sourceDir, targetDir, { recursive: true })
validateFetchTree(targetDir)
execFileSync('node', [resolve(scriptDir, 'build_google_play_fetch_indexes.mjs'), targetDir], { stdio: 'inherit' })

console.log(`Staged Google Play fetch assets:`)
console.log(`- source: ${sourceDir}`)
console.log(`- target: ${targetDir}`)
