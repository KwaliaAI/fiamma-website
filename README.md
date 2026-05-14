# Fiamma Website

Production web app for Fiamma Books (`https://fiammabooks.com`).

## Stack

- React + TypeScript + Vite
- Supabase (auth, catalog, reader profile, unlocks, progress)
- Netlify Functions + Edge Functions

## Key features

- Catalog + book pages
- Reader gate (magic link + OTP) with email request intake
- Complimentary-read entitlement logic (2 credits)
- Reader shelf and cross-device progress persistence
- MailerLite subscriber sync (non-blocking)
- Dynamic metadata edge function

## Required env

Client/runtime:

- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_ANON_KEY`
- `VITE_APP_URL`

Netlify function/runtime:

- `MAILERLITE_API_KEY`
- `MAILERLITE_GROUP_ID`
- `KWALIA_SMTP_USER`
- `KWALIA_SMTP_PASSWORD`
- `KWALIA_SMTP_HOST`
- `KWALIA_SMTP_PORT`
- `FIAMMA_NEW_READER_ALERT_TO`

Ops/QA scripts:

- `NETLIFY_AUTH_TOKEN`
- `SUPABASE_ACCESS_TOKEN`

See `.env.example` for local scaffold.

## Commands

```bash
npm install
npm run dev
npm run build
npm run lint
npm run housekeeping:gate
npm run release:gate
```

Production deploy:

```bash
npm run deploy:prod
```

`deploy:prod` now calls `release:gate` first (`clean git + lint + build`), then performs production deploy.

The clean-worktree gate aborts if git is dirty unless you explicitly set:

```bash
ALLOW_DIRTY_DEPLOY=1 npm run deploy:prod
```

Use the override only with explicit Founder approval and log the reason in handoff.

Install pre-push housekeeping hook:

```bash
bash /home/oss/_agents/shared/scripts/install_pre_push_housekeeping.sh /home/oss/workspace/fiamma-website
```

## QA gate

Promise-integrity gate (5 accounts):

```bash
node scripts/promise_integrity_gate.mjs
```

Generates a local report file `qa_promise_integrity_report_YYYYMMDD.md`.

Reader funnel snapshot:

```bash
npm run funnel:report -- --window yesterday
```

Uses Supabase as the canonical source for reader sign-ins and reading activity.

Reader intake + alerting:

- Email requests are tracked through the Supabase RPC `fiamma_touch_reader_intake`.
- First-time reader sign-ins are canonicalized through the Supabase RPC `fiamma_touch_reader_profile`.
- Production Netlify function `fiamma-reader-sync` sends an email alert on each new non-`@example.com` profile.

Reader onboarding contract:

- See [docs/READER_ONBOARDING.md](docs/READER_ONBOARDING.md) for the canonical checklist.
- Run `npm run reader:onboarding:check` and `npm run reader:db:check` before releasing new reader-manifest content.
- `reader:db:check` prevents the static-site-only launch bug where a new visible title exists in the reader but is missing from live `fiamma_books`, causing complimentary unlocks to fail with Postgres `23503`.

## Repository housekeeping (mandatory)

Before deploy/migration actions:

1. Branch from `main`.
2. Commit checkpoint(s).
3. Run `build` + `lint`.
4. Deploy from committed state.

No deploys from uncommitted local state.
