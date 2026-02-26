import { useEffect, useState } from 'react'
import { BookCard } from '@/components/BookCard'
import { type HeteronymCardData, HeteronymCard } from '@/components/HeteronymCard'
import { Footer } from '@/components/layout/Footer'
import { Navbar } from '@/components/layout/Navbar'
import { getVisibleBooks } from '@/lib/fiammaApi'
import type { FiammaBook } from '@/types/fiamma'

const imprints = [
  {
    title: 'Fiamma Contemporary',
    description:
      "Stories for right now. No waiting, no permission, just the heat that happens when two people stop pretending they don't want it.",
  },
  {
    title: 'Fiamma Classics',
    description: "Old-world repression meets modern desire. Because honestly? Those corsets were never meant to stay laced.",
  },
  {
    title: 'Fiamma Fuoco',
    description:
      "Zero chill. For when you're done with the slow burn and just want the fire. Dante's Inferno was just the warm-up.",
  },
  {
    title: 'Fiamma Spark',
    description:
      "The ache of the build. The tension that makes you want to scream at the characters to just do it already. It's slow, it's painful, and it's always worth the wait.",
  },
]

const heteronyms: HeteronymCardData[] = [
  {
    name: 'Aubrey Kenneth-Moss',
    slug: 'aubrey-kenneth-moss',
    bio: "Dry, precise, and unapologetically high-heat. Aubrey writes the kind of tension that makes you hold your breath—usually in professional settings where everyone is too competent to admit they're in trouble.",
    imagePath: '/assets/heteronyms/aubrey/portrait_author_3x4_1200x1600.png',
    videoPath: '/assets/heteronyms/aubrey/hover_loop.mp4',
    status: 'active',
  },
  {
    name: 'Seph Blackwood',
    slug: 'seph-blackwood',
    bio: "Dark glamour and dangerous longing. Seph writes for the 3 AM crowd, chasing the kind of obsession that doesn't resolve cleanly and stays with you long after the lights come up.",
    imagePath: '/assets/heteronyms/seph/portrait_author_3x4_1200x1600.png',
    status: 'active',
  },
  {
    name: 'Casey Blake',
    slug: 'casey',
    bio: 'Casey Blake writes the heart of the game. From messy dorm rooms to high-stakes Olympic arenas, she captures the grit, sweat, and undeniable heat of college and professional sports romance. Unpretentious, authentic, and always game-day ready.',
    imagePath: '/assets/heteronyms/casey/portrait_author_3x4_1200x1600.png',
    videoPath: '/assets/heteronyms/casey/hover_loop.mp4',
    status: 'upcoming',
  },
]

export function HomePage() {
  const [books, setBooks] = useState<FiammaBook[]>([])

  useEffect(() => {
    getVisibleBooks().then(setBooks).catch(() => setBooks([]))
  }, [])

  return (
    <div className="bg-fiamma-bg text-fiamma-text antialiased">
      <Navbar />

      <header className="section-padding pt-32 md:pt-40">
        <div className="mx-auto max-w-4xl text-center">
          <img src="/assets/fiamma-triangle.png" alt="Fiamma Books" className="mx-auto mb-8 h-32 md:h-40" />
          <h1 className="mb-6 text-5xl font-bold text-fiamma-text md:text-7xl">
            Romance <span className="text-fiamma-coral">on Fire</span>
          </h1>
          <p className="mx-auto mb-8 max-w-2xl text-xl text-gray-600 md:text-2xl">
            We&apos;re here for the stories that make you hold your breath. No coy metaphors, no fade-to-blacks&mdash;just high
            heat and the kind of chemistry that ruins your sleep schedule. If it doesn&apos;t burn, we don&apos;t publish it.
          </p>
          <a
            href="/books"
            className="inline-block rounded-full bg-fiamma-coral px-8 py-4 font-semibold text-white transition-colors hover:bg-fiamma-dark"
          >
            Explore Our Books
          </a>
        </div>
      </header>

      <section id="books" className="section-padding">
        <div className="mx-auto max-w-6xl">
          <h2 className="mb-4 text-center text-4xl font-bold md:text-5xl">Our Books</h2>
          <p className="mx-auto mb-12 max-w-xl text-center text-gray-600">
            Stories that burn through traditional publishing boundaries.
          </p>

          <div className="grid gap-8 md:grid-cols-3">
            {books.map((book) => (
              <BookCard key={book.title_id} book={book} />
            ))}
          </div>
        </div>
      </section>

      <section id="heteronyms" className="section-padding">
        <div className="mx-auto max-w-6xl">
          <h2 className="mb-4 text-center text-4xl font-bold md:text-5xl">Heteronyms</h2>
          <p className="mx-auto mb-12 max-w-2xl text-center text-gray-600">
            Distinct author identities shaping new worlds across Fiamma&apos;s evolving catalog.
          </p>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {heteronyms.map((heteronym) => (
              <HeteronymCard key={heteronym.slug} {...heteronym} />
            ))}
          </div>
        </div>
      </section>

      <section id="imprints" className="section-padding bg-white">
        <div className="mx-auto max-w-6xl">
          <h2 className="mb-4 text-center text-4xl font-bold md:text-5xl">Our Imprints</h2>
          <p className="mx-auto mb-12 max-w-xl text-center text-gray-600">Four flames, one fire. Find your heat level.</p>

          <div className="grid gap-8 md:grid-cols-2">
            {imprints.map((imprint) => (
              <div
                key={imprint.title}
                className="rounded-2xl border-2 border-gray-100 p-8 transition-colors hover:border-fiamma-coral"
              >
                <h3 className="mb-3 font-display text-2xl font-bold">{imprint.title}</h3>
                <p className="text-gray-600">{imprint.description}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section id="about" className="section-padding">
        <div className="mx-auto max-w-4xl">
          <h2 className="mb-8 text-center text-4xl font-bold md:text-5xl">About Fiamma</h2>
          <div className="prose mx-auto text-center prose-lg">
            <p className="mb-6 text-xl text-gray-600">
              Fiamma means flame. We started this because we were bored of &quot;safe&quot; romance and &quot;nice&quot; stories. We
              look for the scenes that make you stare at the wall for ten minutes after the chapter ends. We strike
              matches; you bring the air.
            </p>
          </div>
        </div>
      </section>

      <section className="section-padding bg-fiamma-coral text-white">
        <div className="mx-auto max-w-4xl text-center">
          <h2 className="mb-8 text-4xl font-bold md:text-5xl">Who Reads Fiamma</h2>
          <p className="mb-4 text-xl opacity-90">
            People who aren&apos;t looking for a &quot;sweet read.&quot; Our readers want stories that bite back&mdash;the ones who
            value chemistry over comfort and heat that doesn&apos;t apologize for existing.
          </p>
        </div>
      </section>

      <section id="contact" className="section-padding">
        <div className="mx-auto max-w-2xl text-center">
          <h2 className="mb-8 text-4xl font-bold md:text-5xl">Get in Touch</h2>
          <p className="mb-8 text-gray-600">Questions, submissions, or just want to say hello? We&apos;d love to hear from you.</p>
          <a
            href="mailto:hello@fiammabooks.com"
            className="inline-block rounded-full bg-fiamma-text px-8 py-4 font-semibold text-white transition-colors hover:bg-gray-800"
          >
            hello@fiammabooks.com
          </a>
        </div>
      </section>

      <Footer />
    </div>
  )
}
