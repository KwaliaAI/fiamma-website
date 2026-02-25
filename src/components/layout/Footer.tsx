export function Footer() {
  return (
    <footer className="bg-fiamma-text py-12 text-white">
      <div className="mx-auto max-w-6xl px-6">
        <div className="flex flex-col items-center justify-between md:flex-row">
          <div className="mb-6 md:mb-0">
            <img src="/assets/fiamma-logo.png" alt="Fiamma Books" className="h-8 brightness-0 invert" />
            <p className="mt-3 text-sm text-gray-400">Setting bookshelves (and hearts) on fire since 2025</p>
          </div>
          <div className="flex space-x-6 text-gray-400">
            <a href="https://kwalia.ai" className="transition-colors hover:text-white">
              A Kwalia Imprint
            </a>
          </div>
        </div>
        <div className="mt-8 border-t border-gray-700 pt-8 text-center text-sm text-gray-400">
          <p>&copy; 2025 Fiamma Books. All rights reserved.</p>
        </div>
      </div>
    </footer>
  )
}
