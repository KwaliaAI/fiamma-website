ALTER TABLE public.fiamma_reader_profiles
  ADD COLUMN IF NOT EXISTS gift_credits_total integer NOT NULL DEFAULT 1,
  ADD COLUMN IF NOT EXISTS gift_credits_remaining integer NOT NULL DEFAULT 1;

ALTER TABLE public.fiamma_book_unlocks
  ADD COLUMN IF NOT EXISTS is_gift_unlock boolean NOT NULL DEFAULT false;

CREATE OR REPLACE FUNCTION public.fiamma_claim_gift_unlock(p_book_id text)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_user_id uuid := auth.uid();
  v_remaining integer;
  v_total integer;
  v_already_unlocked boolean;
BEGIN
  IF v_user_id IS NULL THEN
    RAISE EXCEPTION 'Authentication required';
  END IF;

  SELECT gift_credits_remaining, gift_credits_total
    INTO v_remaining, v_total
  FROM public.fiamma_reader_profiles
  WHERE user_id = v_user_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RETURN jsonb_build_object(
      'status', 'profile_missing',
      'gift_credits_remaining', 0,
      'gift_credits_total', 1
    );
  END IF;

  SELECT EXISTS (
    SELECT 1
    FROM public.fiamma_book_unlocks
    WHERE user_id = v_user_id
      AND book_id = p_book_id
  ) INTO v_already_unlocked;

  IF v_already_unlocked THEN
    RETURN jsonb_build_object(
      'status', 'already_unlocked',
      'gift_credits_remaining', v_remaining,
      'gift_credits_total', v_total
    );
  END IF;

  IF v_remaining <= 0 THEN
    RETURN jsonb_build_object(
      'status', 'no_credits',
      'gift_credits_remaining', v_remaining,
      'gift_credits_total', v_total
    );
  END IF;

  INSERT INTO public.fiamma_book_unlocks (user_id, book_id, is_gift_unlock)
  VALUES (v_user_id, p_book_id, true)
  ON CONFLICT (user_id, book_id) DO UPDATE
    SET is_gift_unlock = true;

  UPDATE public.fiamma_reader_profiles
  SET gift_credits_remaining = gift_credits_remaining - 1,
      last_seen = now()
  WHERE user_id = v_user_id;

  RETURN jsonb_build_object(
    'status', 'unlocked',
    'gift_credits_remaining', GREATEST(v_remaining - 1, 0),
    'gift_credits_total', v_total
  );
END;
$$;

REVOKE ALL ON FUNCTION public.fiamma_claim_gift_unlock(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.fiamma_claim_gift_unlock(text) TO authenticated;
