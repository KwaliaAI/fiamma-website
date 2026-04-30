import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { BookCard } from '@/components/BookCard'
import { Footer } from '@/components/layout/Footer'
import { Navbar } from '@/components/layout/Navbar'
import { getVisibleBooks } from '@/lib/fiammaApi'
import { getHeteronymProfileBySlug } from '@/lib/heteronyms'
import { getPublicImprints } from '@/lib/fiammaBrand'
import type { FiammaBook } from '@/types/fiamma'

export function HomePage() {
  const [books, setBooks] = useState<FiammaBook[]>([])
  const featuredAuthor = useMemo(() => getHeteronymProfileBySlug('hailey-boone'), [])
  const publicImprints = useMemo(() => getPublicImprints(), [])

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
            We&apos;re here for the stories that make you hold your breath. Fiamma publishes the romance worth reading,
            written by AI. We want longing, pressure, and the moment everything tips. If it doesn&apos;t burn, we don&apos;t
            publish it.
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

      <section className="section-padding bg-white">
        <div className="mx-auto grid max-w-6xl gap-8 lg:grid-cols-[1.15fr,0.85fr] lg:items-center">
          <div>
            <p className="mb-3 text-sm font-semibold uppercase tracking-[0.28em] text-fiamma-coral">Featured author</p>
            <h2 className="mb-4 font-display text-4xl font-bold md:text-5xl">{featuredAuthor?.name ?? 'Hailey Boone'}</h2>
            <p className="mb-6 text-lg leading-8 text-gray-700">
              {featuredAuthor?.seoDescription ??
                "Montana ranch romance with heat, restraint, and a clean emotional line. Hailey Boone writes the Paradise Valley series for readers who want the pull to feel earned."}
            </p>
            <div className="flex flex-wrap gap-3">
              <Link
                to="/heteronyms/hailey-boone"
                className="rounded-full bg-fiamma-coral px-6 py-3 font-semibold text-white transition-colors hover:bg-fiamma-dark"
              >
                Read the author page
              </Link>
              <Link
                to="/heteronyms"
                className="rounded-full border border-fiamma-coral px-6 py-3 font-semibold text-fiamma-coral transition-colors hover:bg-fiamma-coral hover:text-white"
              >
                Meet all authors
              </Link>
            </div>
          </div>

          <div className="overflow-hidden rounded-3xl border border-gray-200 bg-gray-50 shadow-sm">
            {featuredAuthor ? (
              <img src={featuredAuthor.imagePath} alt={`${featuredAuthor.name} portrait`} className="aspect-[4/5] w-full object-cover" />
            ) : null}
          </div>
        </div>
      </section>

      <section id="imprints" className="section-padding bg-white">
        <div className="mx-auto max-w-6xl">
          <h2 className="mb-4 text-center text-4xl font-bold md:text-5xl">Our Imprints</h2>
          <p className="mx-auto mb-12 max-w-xl text-center text-gray-600">Four flames, one fire. Find your heat level.</p>

          <div className="grid gap-8 md:grid-cols-2">
            {publicImprints.map((imprint) => (
              <div
                key={imprint.id}
                className="rounded-2xl border-2 border-gray-100 p-8 transition-colors hover:border-fiamma-coral"
              >
                <h3 className="mb-3 font-display text-2xl font-bold">{imprint.title}</h3>
                <p className="text-gray-600">{imprint.shortDescription}</p>
                <Link to="/imprints" className="mt-4 inline-block text-sm font-semibold text-fiamma-coral underline-offset-4 hover:underline">
                  Explore the imprint
                </Link>
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
