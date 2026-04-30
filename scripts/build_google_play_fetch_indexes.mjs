#!/usr/bin/env node

import { existsSync, mkdirSync, readdirSync, statSync, writeFileSync } from 'node:fs'
import { join, relative, sep } from 'node:path'

const rootDir = process.argv[2] ? process.argv[2] : new URL('../public/google-play/fetch', import.meta.url).pathname

function toHref(fromDir, targetPath) {
  const rel = relative(fromDir, targetPath).split(sep).join('/')
  return encodeURI(rel)
}

function humanSize(bytes) {
  if (bytes < 1024) return `${bytes} B`
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`
}

function renderIndex(dirPath) {
  const entries = readdirSync(dirPath, { withFileTypes: true })
    .filter((entry) => entry.name !== 'index.html' && entry.name !== 'index.htm')
    .map((entry) => {
      const fullPath = join(dirPath, entry.name)
      const stats = statSync(fullPath)
      return {
        name: entry.name,
        fullPath,
        isDirectory: entry.isDirectory(),
        size: entry.isDirectory() ? '-' : humanSize(stats.size),
        mtime: stats.mtime.toISOString().replace('T', ' ').replace('Z', ' UTC'),
      }
    })
    .sort((a, b) => {
      if (a.isDirectory !== b.isDirectory) return a.isDirectory ? -1 : 1
      return a.name.localeCompare(b.name)
    })

  const parentLink = relative(rootDir, dirPath) ? `<p><a href="../">Parent directory</a></p>` : ''
  const rows = entries
    .map((entry) => {
      const href = entry.isDirectory ? `${toHref(dirPath, entry.fullPath)}/` : toHref(dirPath, entry.fullPath)
      const label = entry.isDirectory ? `${entry.name}/` : entry.name
      return `<tr><td><a href="${href}">${label}</a></td><td>${entry.size}</td><td>${entry.mtime}</td></tr>`
    })
    .join('\n')

  const title = `Index of /${relative(rootDir, dirPath).split(sep).join('/')}${relative(rootDir, dirPath) ? '/' : ''}`
  return `<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>${title}</title>
  <style>
    body { font-family: system-ui, sans-serif; margin: 2rem; line-height: 1.4; }
    table { border-collapse: collapse; width: 100%; max-width: 980px; }
    th, td { padding: 0.45rem 0.75rem; border-bottom: 1px solid #ddd; text-align: left; }
    th { background: #f7f7f7; }
    a { color: #0b57d0; text-decoration: none; }
    a:hover { text-decoration: underline; }
    .meta { color: #666; margin-bottom: 1rem; }
  </style>
</head>
<body>
  <h1>${title}</h1>
  <div class="meta">Google Play auto-fetch directory listing.</div>
  ${parentLink}
  <table>
    <thead>
      <tr><th>Name</th><th>Size</th><th>Modified</th></tr>
    </thead>
    <tbody>
      ${rows}
    </tbody>
  </table>
</body>
</html>
`
}

function walk(dirPath) {
  if (!existsSync(dirPath)) {
    return
  }

  const entries = readdirSync(dirPath, { withFileTypes: true })
  for (const entry of entries) {
    if (entry.isDirectory()) {
      walk(join(dirPath, entry.name))
    }
  }

  writeFileSync(join(dirPath, 'index.html'), renderIndex(dirPath), 'utf8')
}

mkdirSync(rootDir, { recursive: true })
walk(rootDir)
console.log(`Generated Google Play fetch indexes under ${rootDir}`)
