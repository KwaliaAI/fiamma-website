import { promises as fs } from 'node:fs'
import path from 'node:path'

const rootDir = process.cwd()
const readerDir = path.join(rootDir, 'public', 'data', 'reader')
const localFiammaBooksPath = path.join(rootDir, 'src', 'lib', 'localFiammaBooks.ts')

function markProblem(problems, message) {
  problems.push(message)
}

async function pathExists(filePath) {
  try {
    await fs.access(filePath)
    return true
  } catch {
    return false
  }
}

// Extract { title_id, visible } pairs from the TypeScript source.
// Each book is an object literal containing both `title_id: '<id>'` and `visible: <bool>`.
// We parse object-by-object to keep the pairing correct.
async function loadVisibleTitleIds() {
  if (!(await pathExists(localFiammaBooksPath))) {
    return null
  }
  const source = await fs.readFile(localFiammaBooksPath, 'utf8')
  const objects = source.split(/\}\s*,\s*\{/)
  const visibleIds = []
  for (const block of objects) {
    const titleMatch = block.match(/title_id:\s*['"]([^'"]+)['"]/)
    const visibleMatch = block.match(/visible:\s*(true|false)/)
    if (titleMatch && visibleMatch && visibleMatch[1] === 'true') {
      visibleIds.push(titleMatch[1])
    }
  }
  return visibleIds
}

async function main() {
  const problems = []

  // Gate 1 (added 2026-05-01): every visible book in localFiammaBooks.ts must have a manifest folder.
  // Why: the previous version validated only existing folders; HB-001/002/003 shipped to /read/ with
  // no manifest and no Supabase chapters and silently fell back to "Chapters are coming soon."
  // The reader-funnel audit (report_subagent_fiamma-reader-funnel-audit_2026-05-01.md) caught this.
  const visibleIds = await loadVisibleTitleIds()
  if (visibleIds === null) {
    console.warn(`warning: could not read ${localFiammaBooksPath} — visible-books gate skipped`)
  }

  if (!(await pathExists(readerDir))) {
    if (visibleIds && visibleIds.length > 0) {
      for (const id of visibleIds) {
        markProblem(problems, `${id}: visible:true in localFiammaBooks but no public/data/reader directory exists at all`)
      }
      for (const problem of problems) console.error(problem)
      process.exitCode = 1
      return
    }
    console.log('No reader onboarding content found.')
    return
  }

  const folders = (await fs.readdir(readerDir, { withFileTypes: true })).filter((entry) => entry.isDirectory())

  if (visibleIds) {
    const folderNames = new Set(folders.map((f) => f.name))
    for (const id of visibleIds) {
      if (!folderNames.has(id)) {
        markProblem(problems, `${id}: visible:true in localFiammaBooks but no manifest folder at public/data/reader/${id}/`)
      }
    }
  }

  if (folders.length === 0) {
    if (problems.length > 0) {
      for (const problem of problems) console.error(problem)
      process.exitCode = 1
      return
    }
    console.log('No reader onboarding content found.')
    return
  }

  for (const folder of folders) {
    const folderPath = path.join(readerDir, folder.name)
    const manifestPath = path.join(folderPath, 'manifest.json')
    if (!(await pathExists(manifestPath))) {
      markProblem(problems, `${folder.name}: missing manifest.json`)
      continue
    }

    const manifest = JSON.parse(await fs.readFile(manifestPath, 'utf8'))
    if (!manifest.bookId || manifest.bookId !== folder.name) {
      markProblem(problems, `${folder.name}: bookId must match folder name`)
    }
    if (!manifest.generatedAt) {
      markProblem(problems, `${folder.name}: missing generatedAt`)
    }
    if (!Array.isArray(manifest.chapters) || manifest.chapters.length === 0) {
      markProblem(problems, `${folder.name}: chapters array is empty`)
      continue
    }

    const chapterNumbers = manifest.chapters.map((item) => item.chapter_number).sort((left, right) => left - right)
    chapterNumbers.forEach((chapterNumber, index) => {
      if (chapterNumber !== index + 1) {
        markProblem(problems, `${folder.name}: chapter numbering is not contiguous starting at 1`)
      }
    })

    for (const chapter of manifest.chapters) {
      if (!chapter.path || typeof chapter.path !== 'string') {
        markProblem(problems, `${folder.name}: chapter ${chapter.chapter_number} missing path`)
        continue
      }

      const chapterPath = path.join(rootDir, 'public', chapter.path.replace(/^\/+/, ''))
      if (!(await pathExists(chapterPath))) {
        markProblem(problems, `${folder.name}: missing chapter file for ${chapter.path}`)
      }
    }
  }

  if (problems.length > 0) {
    for (const problem of problems) {
      console.error(problem)
    }
    process.exitCode = 1
    return
  }

  console.log(`Reader onboarding contract passed for ${folders.length} manifest folder(s).`)
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})

