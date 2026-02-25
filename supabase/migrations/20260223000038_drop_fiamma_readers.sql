-- fiamma_readers was a pre-auth legacy table (email + last_seen + books_accessed[]).
-- It is fully superseded by:
--   fiamma_reader_profiles (user_id + email + last_seen, auth-linked)
--   fiamma_book_unlocks (user_id + book_id)
-- Dropping it cleanly.

DROP TABLE IF EXISTS public.fiamma_readers;
