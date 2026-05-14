# Reader Onboarding Contract

This document is the operating contract for adding a new Fiamma title to the reader experience.

## Purpose

Every new title should behave the same way for a reader:

- request access with an email
- receive a sign-in link
- be recorded in the reader database
- resume from the last saved chapter on return
- keep the shelf state aligned with actual progress

## Canonical rule

Reader onboarding is complete only when the following are true:

- the title exists in `fiamma_books`
- the title is visible in the web catalog
- the reader gate copy is correct for the current entitlement rule
- the reader manifest exists under `public/data/reader/<book-id>/manifest.json`
- every chapter path in the manifest exists
- chapter numbers are contiguous starting at 1
- saved progress routes returning readers back to their last chapter
- the shelf can show a progress-aware CTA for the title

## Current entitlement rule

Fiamma reader access currently gives readers the first two books as complimentary reads.

That means all catalog, book, and gate copy should say:

- the first two books are complimentary, or
- the first two books are our gift, or
- an equivalent phrase that does not contradict the rule above

Do not say the first book is free unless the entitlement rule changes everywhere.

## Required assets for a new reader title

- book metadata in the canonical catalog source
- cover art
- reader manifest at `public/data/reader/<book-id>/manifest.json`
- chapter files referenced by the manifest
- if the title is meant to be readable, a routable `/read/:slug` path
- if the title is meant to be resumable, saved progress must persist in Supabase

## Operational flow

1. Reader enters email.
2. The request is recorded in Supabase through the intake RPC.
3. The sign-in link is sent.
4. The reader profile is activated on first successful sign-in.
5. The reader is routed to the last saved chapter if one exists.
6. Progress updates on each chapter view.
7. The shelf reflects last chapter, completion, and resume state.

## Onboarding check

Run the local contract check before release:

```bash
npm run reader:onboarding:check
npm run reader:db:check
```

The onboarding check verifies the reader-manifest tree for completeness and obvious drift.

The database check verifies every `visible: true` title in `src/lib/localFiammaBooks.ts` has a matching visible row in live `public.fiamma_books`. This is a hard reader-access contract: `public.fiamma_book_unlocks.book_id` has a foreign key to `public.fiamma_books(title_id)`, so a static-site-only title will authenticate successfully and then fail complimentary unlock with Postgres error `23503`.

Before marking a new title launch-ready, seed or upsert the `public.fiamma_books` row first, then run both checks.
