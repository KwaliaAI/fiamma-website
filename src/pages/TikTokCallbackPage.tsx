import { Link, useSearchParams } from 'react-router-dom'

function DetailRow({ label, value }: { label: string; value: string }) {
  return (
    <div className="rounded-2xl border border-fiamma-coral/20 bg-white/80 p-4 text-left">
      <p className="text-xs font-semibold uppercase tracking-[0.2em] text-fiamma-coral">{label}</p>
      <p className="mt-2 break-all font-mono text-sm text-fiamma-text">{value}</p>
    </div>
  )
}

export function TikTokCallbackPage() {
  const [searchParams] = useSearchParams()

  const code = searchParams.get('code')
  const state = searchParams.get('state')
  const error = searchParams.get('error')
  const errorDescription = searchParams.get('error_description')

  const title = error ? 'TikTok Connection Failed' : code ? 'TikTok Connected' : 'TikTok Callback Ready'
  const description = error
    ? 'TikTok redirected back with an error. Keep this page open for debugging and return to the setup flow.'
    : code
      ? 'TikTok redirected back successfully. The authorization response reached the Fiamma domain.'
      : 'This callback route is ready. TikTok should redirect here after authorization.'

  return (
    <main className="section-padding min-h-[calc(100vh-160px)]">
      <div className="mx-auto max-w-3xl rounded-[2rem] border border-fiamma-coral/20 bg-gradient-to-br from-white via-[#fff8f5] to-[#ffe9e3] p-8 shadow-[0_30px_90px_rgba(242,139,130,0.18)] md:p-12">
        <div className="inline-flex rounded-full border border-fiamma-coral/30 bg-white px-4 py-2 text-xs font-semibold uppercase tracking-[0.25em] text-fiamma-coral">
          TikTok OAuth Callback
        </div>
        <h1 className="mt-6 text-4xl font-bold text-fiamma-text md:text-5xl">{title}</h1>
        <p className="mt-4 max-w-2xl text-lg text-gray-600">{description}</p>

        <div className="mt-8 grid gap-4">
          {code ? <DetailRow label="Authorization Code" value={code} /> : null}
          {state ? <DetailRow label="State" value={state} /> : null}
          {error ? <DetailRow label="Error" value={error} /> : null}
          {errorDescription ? <DetailRow label="Error Description" value={errorDescription} /> : null}
          {!code && !error ? <DetailRow label="Callback URL" value={window.location.href} /> : null}
        </div>

        <div className="mt-10 flex flex-wrap gap-4">
          <a
            href="https://fiammabooks.com"
            className="inline-flex items-center rounded-full bg-fiamma-coral px-6 py-3 font-semibold text-white transition-colors hover:bg-fiamma-dark"
          >
            Back to Fiamma
          </a>
          <Link
            to="/"
            className="inline-flex items-center rounded-full border border-fiamma-text/15 bg-white px-6 py-3 font-semibold text-fiamma-text transition-colors hover:border-fiamma-coral hover:text-fiamma-coral"
          >
            Open Homepage
          </Link>
        </div>
      </div>
    </main>
  )
}
