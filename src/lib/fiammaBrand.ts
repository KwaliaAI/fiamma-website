import { normalizeHeteronymName } from '@/lib/heteronyms'
import type { FiammaBook } from '@/types/fiamma'

export type FiammaImprintId = 'fiamma-contemporary' | 'fiamma-spark' | 'fiamma-fuoco' | 'fiamma-classics'

export type FiammaImprint = {
  id: FiammaImprintId
  slug: string
  title: string
  positioning: string
  shortDescription: string
  public: boolean
  showSignup?: boolean
}

export const FIAMMA_IMPRINTS: FiammaImprint[] = [
  {
    id: 'fiamma-contemporary',
    slug: 'contemporary',
    title: 'Fiamma Contemporary',
    positioning: 'Stories for right now. No waiting, no permission, just the heat that happens when two people stop pretending they do not want it.',
    shortDescription: 'Modern romance with immediate stakes, sharp chemistry, and contemporary settings.',
    public: true,
  },
  {
    id: 'fiamma-spark',
    slug: 'spark',
    title: 'Fiamma Spark',
    positioning: 'The ache of the build. The tension that makes you want to scream at the characters to just do it already. It is slow, it is painful, and it is always worth the wait.',
    shortDescription: 'Slow-burn romance with pressure, restraint, and payoff that lands hard.',
    public: true,
  },
  {
    id: 'fiamma-fuoco',
    slug: 'fuoco',
    title: 'Fiamma Fuoco',
    positioning: "Zero chill. For when you are done with the slow burn and just want the fire. Dante's Inferno was just the warm-up.",
    shortDescription: 'High-voltage romance for readers who want heat first and questions later.',
    public: true,
    showSignup: true,
  },
  {
    id: 'fiamma-classics',
    slug: 'classics',
    title: 'Fiamma Classics',
    positioning: 'Old-world repression meets modern desire. Because honestly? Those corsets were never meant to stay laced.',
    shortDescription: 'Traditional and historical romance for a later phase of the line.',
    public: false,
  },
]

const heteronymToImprint: Record<string, FiammaImprintId> = {
  'Aubrey Kenneth Moss': 'fiamma-spark',
  'Hailey Boone': 'fiamma-contemporary',
  'Seph Blackwood': 'fiamma-fuoco',
  'Casey Blake': 'fiamma-contemporary',
}

export function getImprintById(id: FiammaImprintId | null | undefined): FiammaImprint | null {
  if (!id) return null
  return FIAMMA_IMPRINTS.find((imprint) => imprint.id === id) ?? null
}

export function getImprintBySlug(slug: string | null | undefined): FiammaImprint | null {
  const normalizedSlug = slug?.trim() ?? ''
  if (!normalizedSlug) return null
  return FIAMMA_IMPRINTS.find((imprint) => imprint.slug === normalizedSlug) ?? null
}

export function getPublicImprints(): FiammaImprint[] {
  return FIAMMA_IMPRINTS.filter((imprint) => imprint.public)
}

export function getBookImprintId(book: Pick<FiammaBook, 'heteronym'> & Partial<Pick<FiammaBook, 'imprint'>>): FiammaImprintId {
  const explicitImprint = book.imprint
  if (explicitImprint && getImprintById(explicitImprint)) return explicitImprint

  const normalizedHeteronym = normalizeHeteronymName(book.heteronym)
  return heteronymToImprint[normalizedHeteronym] ?? 'fiamma-contemporary'
}

export function getBookImprint(book: Pick<FiammaBook, 'heteronym'> & Partial<Pick<FiammaBook, 'imprint'>>): FiammaImprint {
  return getImprintById(getBookImprintId(book)) ?? FIAMMA_IMPRINTS[0]
}
