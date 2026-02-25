import { type ReactNode, useEffect, useRef } from 'react'
import { Navigate, Route, Routes, useLocation } from 'react-router-dom'
import { Footer } from '@/components/layout/Footer'
import { Navbar } from '@/components/layout/Navbar'
import { initAnalytics, trackPageView } from '@/lib/analytics'
import { BookPage } from '@/pages/BookPage'
import { CatalogPage } from '@/pages/CatalogPage'
import { HomePage } from '@/pages/HomePage'
import { ReaderGatePage } from '@/pages/ReaderGatePage'
import { ReaderPage } from '@/pages/ReaderPage'
import { ShelfPage } from '@/pages/ShelfPage'

function AppLayout({ children }: { children: ReactNode }) {
  return (
    <div className="min-h-screen bg-fiamma-bg text-fiamma-text antialiased">
      <Navbar />
      {children}
      <Footer />
    </div>
  )
}

function AnalyticsTracker() {
  const location = useLocation()
  const isFirstView = useRef(true)

  useEffect(() => {
    initAnalytics()
  }, [])

  useEffect(() => {
    if (isFirstView.current) {
      isFirstView.current = false
      return
    }
    trackPageView(`${location.pathname}${location.search}`)
  }, [location.pathname, location.search])

  return null
}

function App() {
  return (
    <>
      <AnalyticsTracker />
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route
          path="/books"
          element={
            <AppLayout>
              <CatalogPage />
            </AppLayout>
          }
        />
        <Route
          path="/books/:slug"
          element={
            <AppLayout>
              <BookPage />
            </AppLayout>
          }
        />
        <Route
          path="/read/:slug"
          element={
            <AppLayout>
              <ReaderGatePage />
            </AppLayout>
          }
        />
        <Route
          path="/read/:slug/:chapter"
          element={
            <AppLayout>
              <ReaderPage />
            </AppLayout>
          }
        />
        <Route
          path="/shelf"
          element={
            <AppLayout>
              <ShelfPage />
            </AppLayout>
          }
        />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </>
  )
}

export default App
