-- Policy update: complimentary reads are restored to 2.
-- Existing users with 0/1 remaining credits are reset to 2 so they can claim a second title.

ALTER TABLE public.fiamma_reader_profiles
  ALTER COLUMN gift_credits_total SET DEFAULT 2,
  ALTER COLUMN gift_credits_remaining SET DEFAULT 2;

UPDATE public.fiamma_reader_profiles
SET
  gift_credits_total = 2,
  gift_credits_remaining = 2
WHERE COALESCE(gift_credits_remaining, 0) <= 1
   OR COALESCE(gift_credits_total, 0) < 2;

NOTIFY pgrst, 'reload schema';
