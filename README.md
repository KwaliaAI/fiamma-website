# Fiamma Website

Production web app for Fiamma Books (`https://fiammabooks.com`).

## Stack

- React + TypeScript + Vite
- Supabase (auth, catalog, reader profile, unlocks, progress)
- Netlify Functions + Edge Functions

## Key features

- Catalog + book pages
- Reader gate (magic link + OTP)
- Complimentary-read entitlement logic (2 credits)
- Reader shelf and progress persistence
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

## Repository housekeeping (mandatory)

Before deploy/migration actions:

1. Branch from `main`.
2. Commit checkpoint(s).
3. Run `build` + `lint`.
4. Deploy from committed state.

No deploys from uncommitted local state.
