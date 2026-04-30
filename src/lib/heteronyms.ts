export type HeteronymStatus = 'active' | 'upcoming'

export interface HeteronymProfile {
  name: string
  slug: string
  catalogName: string
  imprintId: 'fiamma-contemporary' | 'fiamma-spark' | 'fiamma-fuoco' | 'fiamma-classics'
  bio: string
  longBio?: string
  seoDescription: string
  seoTitle: string
  seriesLine?: string
  transparencyLine?: string
  imagePath: string
  videoPath?: string
  status: HeteronymStatus
}

const heteronymAliases: Record<string, string> = {
  'Aubrey Kenneth-Moss': 'Aubrey Kenneth Moss',
}

export function normalizeHeteronymName(name: string | null | undefined): string {
  const trimmed = name?.trim() ?? ''
  if (!trimmed) return ''
  return heteronymAliases[trimmed] ?? trimmed
}

export const heteronymProfiles: HeteronymProfile[] = [
  {
    name: 'Aubrey Kenneth Moss',
    slug: 'aubrey-kenneth-moss',
    catalogName: 'Aubrey Kenneth Moss',
    imprintId: 'fiamma-spark',
    bio: "Dry, precise, and unapologetically high-heat. Aubrey writes the kind of tension that makes you hold your breath, usually in professional settings where everyone is too competent to admit they're in trouble.",
    seoDescription:
      'Aubrey Kenneth Moss writes high-heat, slow-burn romance for readers who like precision, pressure, and a payoff that lands hard. Explore the Fiamma Spark catalog.',
    seoTitle: 'Aubrey Kenneth Moss — Fiamma Spark | Fiamma Books',
    imagePath: '/assets/heteronyms/aubrey/portrait_author_3x4_1200x1600.png',
    videoPath: '/assets/heteronyms/aubrey/hover_loop.mp4',
    status: 'active',
  },
  {
    name: 'Seph Blackwood',
    slug: 'seph-blackwood',
    catalogName: 'Seph Blackwood',
    imprintId: 'fiamma-fuoco',
    bio: "Dark glamour and dangerous longing. Seph writes for the 3 AM crowd, chasing the kind of obsession that doesn't resolve cleanly and stays with you long after the lights come up.",
    seoDescription:
      'Seph Blackwood writes dark, high-voltage romance for readers who want glamour, danger, and heat that does not apologize for itself.',
    seoTitle: 'Seph Blackwood — Fiamma Fuoco | Fiamma Books',
    imagePath: '/assets/heteronyms/seph/portrait_author_3x4_1200x1600.png',
    status: 'active',
  },
  {
    name: 'Hailey Boone',
    slug: 'hailey-boone',
    catalogName: 'Hailey Boone',
    imprintId: 'fiamma-contemporary',
    bio: "Hailey Boone writes cowboy-ranch contemporary romance set in Montana's Paradise Valley. Mud Season is her debut.",
    longBio:
      'Hailey Boone writes blue-collar cowboy-ranch contemporary romance with a city woman, a quiet man, and a working ranch that does not wait for either of them to figure it out. Mud Season is her debut, the first novel in the Paradise Valley series. She counts hours, notes the weather, and does not write heroines who need rescuing. She writes women who show up in the wrong shoes and stay anyway.',
    seoDescription:
      'Hailey Boone writes Montana ranch romance with heat, restraint, and real emotional stakes. Mud Season opens the Paradise Valley series on Fiamma Contemporary.',
    seoTitle: 'Hailey Boone — Fiamma Contemporary | Fiamma Books',
    seriesLine: "Paradise Valley is Hailey Boone's Montana cowboy-ranch contemporary romance series.",
    transparencyLine: "Hailey Boone is an AI heteronym published by Fiamma Books, Kwalia's romance imprint.",
    imagePath: '/assets/heteronyms/hailey-boone/portrait_author_3x4_1200x1600.png',
    status: 'active',
  },
  {
    name: 'Casey Blake',
    slug: 'casey',
    catalogName: 'Casey Blake',
    imprintId: 'fiamma-contemporary',
    bio: 'Casey Blake writes the heart of the game. From messy dorm rooms to high-stakes Olympic arenas, she captures the grit, sweat, and undeniable heat of college and professional sports romance. Unpretentious, authentic, and always game-day ready.',
    seoDescription:
      'Casey Blake writes college and professional sports romance with grit, momentum, and undeniable chemistry for Fiamma Contemporary.',
    seoTitle: 'Casey Blake — Fiamma Contemporary | Fiamma Books',
    imagePath: '/assets/heteronyms/casey/portrait_author_3x4_1200x1600.png',
    videoPath: '/assets/heteronyms/casey/hover_loop.mp4',
    status: 'upcoming',
  },
]

export function getHeteronymProfileBySlug(slug: string): HeteronymProfile | null {
  return heteronymProfiles.find((profile) => profile.slug === slug) ?? null
}

export function getHeteronymProfileByName(name: string | null | undefined): HeteronymProfile | null {
  const normalized = normalizeHeteronymName(name)
  if (!normalized) return null
  return heteronymProfiles.find((profile) => profile.catalogName === normalized) ?? null
}

export function getHeteronymProfilesByImprint(imprintId: HeteronymProfile['imprintId']): HeteronymProfile[] {
  return heteronymProfiles.filter((profile) => profile.imprintId === imprintId)
}

export function matchesHeteronymName(candidate: string | null | undefined, expected: string): boolean {
  return normalizeHeteronymName(candidate) === normalizeHeteronymName(expected)
}
