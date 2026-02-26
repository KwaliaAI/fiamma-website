import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { getReaderSession } from '@/lib/fiammaApi'
import { supabase } from '@/lib/supabase'

const links = [
  { href: '/books', label: 'Books' },
  { href: '/#heteronyms', label: 'Heteronyms' },
  { href: '/#imprints', label: 'Imprints' },
  { href: '/#about', label: 'About' },
  { href: '/#contact', label: 'Contact' },
]

export function Navbar() {
  const [isMobileOpen, setIsMobileOpen] = useState(false)
  const [showShelf, setShowShelf] = useState(false)

  useEffect(() => {
    getReaderSession()
      .then((session) => setShowShelf(Boolean(session?.user)))
      .catch(() => setShowShelf(false))

    const { data: authSubscription } = supabase?.auth.onAuthStateChange((_event, session) => {
      setShowShelf(Boolean(session?.user))
    }) ?? { data: { subscription: null } }

    return () => {
      authSubscription.subscription?.unsubscribe()
    }
  }, [])

  const navLinks = useMemo(() => (showShelf ? [{ href: '/shelf', label: 'My Shelf' }, ...links] : links), [showShelf])

  return (
    <nav className="fixed left-0 right-0 top-0 z-50 border-b border-gray-100 bg-fiamma-bg/95 backdrop-blur-sm">
      <div className="mx-auto flex max-w-6xl items-center justify-between px-6 py-4">
        <Link to="/" className="flex items-center" aria-label="Fiamma Books home">
          <img src="/assets/fiamma-logo.png" alt="Fiamma Books" className="h-6 md:h-8" />
        </Link>
        <div className="hidden space-x-8 md:flex">
          {navLinks.map((link) => (
            <a key={link.href} href={link.href} className="nav-link text-fiamma-text transition-colors hover:text-fiamma-coral">
              {link.label}
            </a>
          ))}
        </div>
        <button
          type="button"
          className="text-fiamma-text md:hidden"
          aria-label="Toggle menu"
          onClick={() => setIsMobileOpen((current) => !current)}
        >
          <svg className="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </button>
      </div>
      <div className={`${isMobileOpen ? 'block' : 'hidden'} border-t border-gray-100 bg-fiamma-bg md:hidden`}>
        <div className="space-y-4 px-6 py-4">
          {navLinks.map((link) => (
            <a key={link.href} href={link.href} className="block text-fiamma-text hover:text-fiamma-coral" onClick={() => setIsMobileOpen(false)}>
              {link.label}
            </a>
          ))}
        </div>
      </div>
    </nav>
  )
}
