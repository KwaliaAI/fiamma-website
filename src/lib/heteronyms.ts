export type HeteronymStatus = 'active' | 'upcoming'

export interface HeteronymProfile {
  name: string
  slug: string
  catalogName: string
  bio: string
  longBio?: string
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
    bio: "Dry, precise, and unapologetically high-heat. Aubrey writes the kind of tension that makes you hold your breath, usually in professional settings where everyone is too competent to admit they're in trouble.",
    imagePath: '/assets/heteronyms/aubrey/portrait_author_3x4_1200x1600.png',
    videoPath: '/assets/heteronyms/aubrey/hover_loop.mp4',
    status: 'active',
  },
  {
    name: 'Seph Blackwood',
    slug: 'seph-blackwood',
    catalogName: 'Seph Blackwood',
    bio: "Dark glamour and dangerous longing. Seph writes for the 3 AM crowd, chasing the kind of obsession that doesn't resolve cleanly and stays with you long after the lights come up.",
    imagePath: '/assets/heteronyms/seph/portrait_author_3x4_1200x1600.png',
    status: 'active',
  },
  {
    name: 'Ellie Marsh',
    slug: 'ellie-marsh',
    catalogName: 'Ellie Marsh',
    bio: "Ellie Marsh writes cowboy-ranch contemporary romance set in Montana's Paradise Valley. Mud Season is her debut.",
    longBio:
      'Ellie Marsh writes blue-collar cowboy-ranch contemporary romance with a city woman, a quiet man, and a working ranch that does not wait for either of them to figure it out. Mud Season is her debut, the first novel in the Paradise Valley series. She counts hours, notes the weather, and does not write heroines who need rescuing. She writes women who show up in the wrong shoes and stay anyway.',
    seriesLine: "Paradise Valley is Ellie Marsh's Montana cowboy-ranch contemporary romance series.",
    transparencyLine: "Ellie Marsh is an AI heteronym published by Fiamma Books, Kwalia's romance imprint.",
    imagePath: '/assets/heteronyms/ellie-marsh/portrait_author_3x4_1200x1600.png',
    status: 'active',
  },
  {
    name: 'Casey Blake',
    slug: 'casey',
    catalogName: 'Casey Blake',
    bio: 'Casey Blake writes the heart of the game. From messy dorm rooms to high-stakes Olympic arenas, she captures the grit, sweat, and undeniable heat of college and professional sports romance. Unpretentious, authentic, and always game-day ready.',
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

export function matchesHeteronymName(candidate: string | null | undefined, expected: string): boolean {
  return normalizeHeteronymName(candidate) === normalizeHeteronymName(expected)
}
