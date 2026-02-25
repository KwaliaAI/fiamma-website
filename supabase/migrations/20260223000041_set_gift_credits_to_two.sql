-- Policy update: complimentary reads are now 2.
-- Existing users keep consumed progress and receive the delta from previous totals.

ALTER TABLE public.fiamma_reader_profiles
  ALTER COLUMN gift_credits_total SET DEFAULT 2,
  ALTER COLUMN gift_credits_remaining SET DEFAULT 2;

UPDATE public.fiamma_reader_profiles
SET
  gift_credits_remaining = LEAST(
    2,
    GREATEST(0, COALESCE(gift_credits_remaining, 0)) + GREATEST(0, 2 - COALESCE(gift_credits_total, 0))
  ),
  gift_credits_total = GREATEST(COALESCE(gift_credits_total, 0), 2)
WHERE COALESCE(gift_credits_total, 0) < 2;

NOTIFY pgrst, 'reload schema';
