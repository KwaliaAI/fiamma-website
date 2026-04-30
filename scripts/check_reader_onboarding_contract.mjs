import { promises as fs } from 'node:fs'
import path from 'node:path'

const rootDir = process.cwd()
const readerDir = path.join(rootDir, 'public', 'data', 'reader')

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

async function main() {
  if (!(await pathExists(readerDir))) {
    console.log('No reader onboarding content found.')
    return
  }

  const folders = (await fs.readdir(readerDir, { withFileTypes: true })).filter((entry) => entry.isDirectory())
  if (folders.length === 0) {
    console.log('No reader onboarding content found.')
    return
  }

  const problems = []

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

