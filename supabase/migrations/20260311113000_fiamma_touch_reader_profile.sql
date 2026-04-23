CREATE OR REPLACE FUNCTION public.fiamma_touch_reader_profile(p_email text)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_user_id uuid := auth.uid();
  v_email text := lower(trim(coalesce(p_email, '')));
  v_created boolean := false;
  v_row_count integer := 0;
BEGIN
  IF v_user_id IS NULL THEN
    RAISE EXCEPTION 'Authentication required';
  END IF;

  IF v_email = '' THEN
    RAISE EXCEPTION 'Email required';
  END IF;

  INSERT INTO public.fiamma_reader_profiles (user_id, email, last_seen)
  VALUES (v_user_id, v_email, now())
  ON CONFLICT DO NOTHING;

  GET DIAGNOSTICS v_row_count = ROW_COUNT;
  v_created := v_row_count > 0;

  IF NOT v_created THEN
    UPDATE public.fiamma_reader_profiles
    SET email = v_email,
        last_seen = now()
    WHERE user_id = v_user_id;

    IF NOT FOUND THEN
      RAISE EXCEPTION 'Reader profile conflict for %', v_email;
    END IF;
  END IF;

  RETURN jsonb_build_object(
    'created', v_created,
    'user_id', v_user_id,
    'email', v_email
  );
END;
$$;

REVOKE ALL ON FUNCTION public.fiamma_touch_reader_profile(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.fiamma_touch_reader_profile(text) TO authenticated;

NOTIFY pgrst, 'reload schema';
