#!/usr/bin/env node

import { cpSync, existsSync, mkdirSync, rmSync } from 'node:fs'
import { dirname, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'

const scriptDir = dirname(fileURLToPath(import.meta.url))
const rootDir = resolve(scriptDir, '..')
const sourceDir = resolve(rootDir, process.env.GOOGLE_PLAY_FETCH_SOURCE ?? '../catalog/out/google_play/fetch')
const targetDir = resolve(rootDir, process.env.GOOGLE_PLAY_FETCH_TARGET ?? 'public/google-play/fetch')

if (!existsSync(sourceDir)) {
  throw new Error(`Google Play fetch source not found: ${sourceDir}`)
}

mkdirSync(dirname(targetDir), { recursive: true })
rmSync(targetDir, { recursive: true, force: true })
cpSync(sourceDir, targetDir, { recursive: true })

console.log(`Staged Google Play fetch assets:`)
console.log(`- source: ${sourceDir}`)
console.log(`- target: ${targetDir}`)
