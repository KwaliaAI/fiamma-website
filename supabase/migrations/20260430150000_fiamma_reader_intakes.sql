CREATE TABLE IF NOT EXISTS public.fiamma_reader_intakes (
  id                 uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email              text NOT NULL UNIQUE,
  preferred_slug     text,
  preferred_mode     text NOT NULL DEFAULT 'magic_link',
  source             text NOT NULL DEFAULT 'web-reader',
  request_count      integer NOT NULL DEFAULT 1,
  requested_at       timestamptz NOT NULL DEFAULT now(),
  last_requested_at  timestamptz NOT NULL DEFAULT now(),
  activated_user_id  uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  activated_at       timestamptz,
  created_at         timestamptz NOT NULL DEFAULT now(),
  updated_at         timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.fiamma_reader_intakes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "fiamma reader intakes select"
ON public.fiamma_reader_intakes FOR SELECT
TO authenticated
USING (auth.uid() = activated_user_id OR is_imprint_admin('fiamma'));

CREATE POLICY "fiamma reader intakes insert"
ON public.fiamma_reader_intakes FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = activated_user_id OR is_imprint_admin('fiamma'));

CREATE POLICY "fiamma reader intakes update"
ON public.fiamma_reader_intakes FOR UPDATE
TO authenticated
USING (auth.uid() = activated_user_id OR is_imprint_admin('fiamma'))
WITH CHECK (auth.uid() = activated_user_id OR is_imprint_admin('fiamma'));

CREATE OR REPLACE FUNCTION public.fiamma_touch_reader_intake(
  p_email text,
  p_slug text DEFAULT NULL,
  p_mode text DEFAULT 'magic_link'
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_email text := lower(trim(coalesce(p_email, '')));
  v_slug text := nullif(trim(coalesce(p_slug, '')), '');
  v_mode text := nullif(trim(coalesce(p_mode, '')), '');
BEGIN
  IF v_email = '' THEN
    RAISE EXCEPTION 'Email required';
  END IF;

  INSERT INTO public.fiamma_reader_intakes (
    email,
    preferred_slug,
    preferred_mode,
    source,
    request_count,
    requested_at,
    last_requested_at,
    updated_at
  )
  VALUES (
    v_email,
    v_slug,
    COALESCE(v_mode, 'magic_link'),
    'web-reader',
    1,
    now(),
    now(),
    now()
  )
  ON CONFLICT (email) DO UPDATE
  SET preferred_slug = COALESCE(EXCLUDED.preferred_slug, public.fiamma_reader_intakes.preferred_slug),
      preferred_mode = COALESCE(EXCLUDED.preferred_mode, public.fiamma_reader_intakes.preferred_mode),
      request_count = public.fiamma_reader_intakes.request_count + 1,
      last_requested_at = now(),
      updated_at = now();

  RETURN jsonb_build_object(
    'ok', true,
    'email', v_email,
    'slug', v_slug,
    'mode', COALESCE(v_mode, 'magic_link')
  );
END;
$$;

REVOKE ALL ON FUNCTION public.fiamma_touch_reader_intake(text, text, text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.fiamma_touch_reader_intake(text, text, text) TO anon, authenticated;

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

  INSERT INTO public.fiamma_reader_intakes (
    email,
    activated_user_id,
    activated_at,
    last_requested_at,
    request_count,
    updated_at
  )
  VALUES (
    v_email,
    v_user_id,
    now(),
    now(),
    1,
    now()
  )
  ON CONFLICT (email) DO UPDATE
  SET activated_user_id = EXCLUDED.activated_user_id,
      activated_at = COALESCE(public.fiamma_reader_intakes.activated_at, EXCLUDED.activated_at),
      last_requested_at = now(),
      updated_at = now();

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
