CREATE TABLE IF NOT EXISTS public.fiamma_readers (
  id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email          text NOT NULL,
  created_at     timestamptz NOT NULL DEFAULT now(),
  last_seen      timestamptz,
  books_accessed text[] NOT NULL DEFAULT '{}',
  UNIQUE (email)
);

ALTER TABLE public.fiamma_readers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "fiamma readers anon insert"
ON public.fiamma_readers FOR INSERT
TO anon, authenticated
WITH CHECK (true);

CREATE POLICY "fiamma readers admin read"
ON public.fiamma_readers FOR SELECT
TO authenticated
USING (is_imprint_admin('fiamma'));
