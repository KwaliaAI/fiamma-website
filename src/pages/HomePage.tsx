import { useEffect, useState } from 'react'
import { BookCard } from '@/components/BookCard'
import { Footer } from '@/components/layout/Footer'
import { Navbar } from '@/components/layout/Navbar'
import { getVisibleBooks } from '@/lib/fiammaApi'
import type { FiammaBook } from '@/types/fiamma'

const imprints = [
  {
    title: 'Fiamma Contemporary',
    description: "Modern love stories where today's world meets timeless passion.",
  },
  {
    title: 'Fiamma Classics',
    description:
      "Historical settings, progressive sensibilities, and corsets that don't stay laced for long.",
  },
  {
    title: 'Fiamma Fuoco',
    description: "Our spiciest line. Dante's Inferno? Just our warm-up notes.",
  },
  {
    title: 'Fiamma Spark',
    description:
      'For readers who prefer tension that builds page by page—but make no mistake, these still bring the heat.',
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
            At Fiamma Books, we don&apos;t just publish romance, we ignite it. Bold voices. Unforgettable stories. Heat
            that leaves a mark.
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
              <em>Fiamma</em>—Italian for &quot;flame&quot;—was founded in 2025 as the publishing home where fresh voices set the
              page ablaze.
            </p>
            <p className="mb-6 text-gray-600">
              While other imprints play it safe, we&apos;re busy striking matches. Our mission? Discover the most
              electrifying new authors and share their stories with readers hungry for romance that leaves a mark.
            </p>
            <p className="text-gray-600">
              Whether you&apos;re looking for a slow burn that simmers for three hundred pages or an explosive connection
              that scorches from chapter one, our catalog burns through traditional publishing boundaries.
            </p>
          </div>
        </div>
      </section>

      <section className="section-padding bg-fiamma-coral text-white">
        <div className="mx-auto max-w-4xl text-center">
          <h2 className="mb-8 text-4xl font-bold md:text-5xl">Who Reads Fiamma</h2>
          <p className="mb-4 text-xl opacity-90">
            Our readers span generations—from the TikTok-savvy twenty-something highlighting passages between classes
            to the seasoned romance aficionado who knows exactly what she wants from her bookshelf.
          </p>
          <p className="text-lg opacity-80">
            What unites them? An appetite for stories that don&apos;t apologize for their heat level.
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
