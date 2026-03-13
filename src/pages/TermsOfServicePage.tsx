export function TermsOfServicePage() {
  return (
    <main className="section-padding">
      <div className="mx-auto max-w-4xl">
        <div className="rounded-[2rem] border border-fiamma-coral/20 bg-white p-8 shadow-[0_24px_60px_rgba(242,139,130,0.12)] md:p-12">
          <div className="inline-flex rounded-full border border-fiamma-coral/30 bg-[#fff5f1] px-4 py-2 text-xs font-semibold uppercase tracking-[0.2em] text-fiamma-coral">
            Terms of Service
          </div>
          <h1 className="mt-6 text-4xl font-bold text-fiamma-text md:text-5xl">Fiamma Books Terms of Service</h1>
          <p className="mt-4 text-sm uppercase tracking-[0.16em] text-gray-500">Effective date: March 12, 2026</p>

          <div className="mt-10 space-y-8 text-gray-700">
            <section>
              <h2 className="text-2xl font-bold text-fiamma-text">What this is</h2>
              <p className="mt-3">
                These terms cover use of <strong>fiammabooks.com</strong>, operated by Fiamma Books.
              </p>
            </section>

            <section>
              <h2 className="text-2xl font-bold text-fiamma-text">Use</h2>
              <p className="mt-3">
                You can browse, read, and buy books. Don&apos;t break anything or scrape content.
              </p>
            </section>

            <section>
              <h2 className="text-2xl font-bold text-fiamma-text">Ownership</h2>
              <p className="mt-3">
                Books, text, artwork, and branding belong to Fiamma Books, Kwalia, or the relevant rights holders. Accessing
                a sample doesn&apos;t transfer rights.
              </p>
            </section>

            <section>
              <h2 className="text-2xl font-bold text-fiamma-text">Availability</h2>
              <p className="mt-3">
                The site may change or go down. We don&apos;t guarantee uptime.
              </p>
            </section>

            <section>
              <h2 className="text-2xl font-bold text-fiamma-text">Liability</h2>
              <p className="mt-3">
                Provided as-is. We&apos;re not liable for indirect or consequential loss from site use, to the extent the law
                allows.
              </p>
            </section>

            <section>
              <h2 className="text-2xl font-bold text-fiamma-text">Contact</h2>
              <p className="mt-3">
                <a className="text-fiamma-coral underline-offset-4 hover:underline" href="mailto:hello@fiammabooks.com">
                  hello@fiammabooks.com
                </a>
              </p>
            </section>
          </div>
        </div>
      </div>
    </main>
  )
}
