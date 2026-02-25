CREATE TABLE IF NOT EXISTS public.fiamma_chapters (
  id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  book_id        text NOT NULL REFERENCES public.fiamma_books(title_id) ON DELETE CASCADE,
  chapter_number integer NOT NULL,
  chapter_title  text,
  content_md     text NOT NULL,
  word_count     integer,
  created_at     timestamptz NOT NULL DEFAULT now(),
  UNIQUE (book_id, chapter_number)
);

CREATE INDEX IF NOT EXISTS idx_fiamma_chapters_book ON public.fiamma_chapters (book_id, chapter_number);

ALTER TABLE public.fiamma_chapters ENABLE ROW LEVEL SECURITY;

CREATE POLICY "fiamma chapters public read"
ON public.fiamma_chapters FOR SELECT
TO anon, authenticated
USING (true);

CREATE POLICY "fiamma chapters admin all"
ON public.fiamma_chapters FOR ALL
TO authenticated
USING (is_imprint_admin('fiamma'))
WITH CHECK (is_imprint_admin('fiamma'));
