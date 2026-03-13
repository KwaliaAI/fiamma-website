export function PrivacyPolicyPage() {
  return (
    <main className="section-padding">
      <div className="mx-auto max-w-4xl">
        <div className="rounded-[2rem] border border-fiamma-coral/20 bg-white p-8 shadow-[0_24px_60px_rgba(242,139,130,0.12)] md:p-12">
          <div className="inline-flex rounded-full border border-fiamma-coral/30 bg-[#fff5f1] px-4 py-2 text-xs font-semibold uppercase tracking-[0.2em] text-fiamma-coral">
            Privacy Policy
          </div>
          <h1 className="mt-6 text-4xl font-bold text-fiamma-text md:text-5xl">Fiamma Books Privacy Policy</h1>
          <p className="mt-4 text-sm uppercase tracking-[0.16em] text-gray-500">Effective date: March 12, 2026</p>

          <div className="mt-10 space-y-8 text-gray-700">
            <section>
              <h2 className="text-2xl font-bold text-fiamma-text">Who we are</h2>
              <p className="mt-3">
                Fiamma Books is a publishing imprint of Kwalia. This policy covers <strong>fiammabooks.com</strong>.
              </p>
            </section>

            <section>
              <h2 className="text-2xl font-bold text-fiamma-text">What we collect</h2>
              <p className="mt-3">
                If you contact us by email, we have your email. If you sign up for updates, we have that too. We use basic
                site analytics, including page views and traffic sources. That&apos;s it.
              </p>
            </section>

            <section>
              <h2 className="text-2xl font-bold text-fiamma-text">What we do with it</h2>
              <p className="mt-3">
                Reply to you. Send updates you asked for. See how the site is doing. We don&apos;t sell data, build profiles,
                or do anything clever with your information.
              </p>
            </section>

            <section>
              <h2 className="text-2xl font-bold text-fiamma-text">Third parties</h2>
              <p className="mt-3">
                The site is hosted on Netlify. Analytics may use standard web tools. We don&apos;t share your contact
                information with anyone.
              </p>
            </section>

            <section>
              <h2 className="text-2xl font-bold text-fiamma-text">Your data</h2>
              <p className="mt-3">
                Want it deleted? Email us. Want to unsubscribe? Use the link in the email.
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
