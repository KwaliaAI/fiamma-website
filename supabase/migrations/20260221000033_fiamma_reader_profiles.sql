CREATE TABLE IF NOT EXISTS public.fiamma_reader_profiles (
  user_id     uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email       text NOT NULL UNIQUE,
  created_at  timestamptz NOT NULL DEFAULT now(),
  last_seen   timestamptz,
  source      text NOT NULL DEFAULT 'web-reader'
);

ALTER TABLE public.fiamma_reader_profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "fiamma reader profiles select"
ON public.fiamma_reader_profiles FOR SELECT
TO authenticated
USING (auth.uid() = user_id OR is_imprint_admin('fiamma'));

CREATE POLICY "fiamma reader profiles insert"
ON public.fiamma_reader_profiles FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id OR is_imprint_admin('fiamma'));

CREATE POLICY "fiamma reader profiles update"
ON public.fiamma_reader_profiles FOR UPDATE
TO authenticated
USING (auth.uid() = user_id OR is_imprint_admin('fiamma'))
WITH CHECK (auth.uid() = user_id OR is_imprint_admin('fiamma'));
