-- Policy update: complimentary reads are now 1.
-- Existing users keep prior consumption, and any extra transitional credit is removed.

ALTER TABLE public.fiamma_reader_profiles
  ALTER COLUMN gift_credits_total SET DEFAULT 1,
  ALTER COLUMN gift_credits_remaining SET DEFAULT 1;

UPDATE public.fiamma_reader_profiles
SET
  gift_credits_remaining = LEAST(
    1,
    GREATEST(
      0,
      COALESCE(gift_credits_remaining, 0) - GREATEST(0, COALESCE(gift_credits_total, 1) - 1)
    )
  ),
  gift_credits_total = 1
WHERE COALESCE(gift_credits_total, 1) <> 1
   OR COALESCE(gift_credits_remaining, 0) > 1;

NOTIFY pgrst, 'reload schema';
