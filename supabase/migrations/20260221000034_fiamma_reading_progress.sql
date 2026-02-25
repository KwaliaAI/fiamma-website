CREATE TABLE IF NOT EXISTS public.fiamma_reading_progress (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  book_id      text NOT NULL REFERENCES public.fiamma_books(title_id) ON DELETE CASCADE,
  last_chapter integer NOT NULL DEFAULT 1,
  completed    boolean NOT NULL DEFAULT false,
  updated_at   timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, book_id)
);

CREATE INDEX IF NOT EXISTS idx_fiamma_reading_progress_user ON public.fiamma_reading_progress(user_id, updated_at DESC);
CREATE INDEX IF NOT EXISTS idx_fiamma_reading_progress_book ON public.fiamma_reading_progress(book_id);

ALTER TABLE public.fiamma_reading_progress ENABLE ROW LEVEL SECURITY;

CREATE POLICY "fiamma progress select"
ON public.fiamma_reading_progress FOR SELECT
TO authenticated
USING (auth.uid() = user_id OR is_imprint_admin('fiamma'));

CREATE POLICY "fiamma progress insert"
ON public.fiamma_reading_progress FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id OR is_imprint_admin('fiamma'));

CREATE POLICY "fiamma progress update"
ON public.fiamma_reading_progress FOR UPDATE
TO authenticated
USING (auth.uid() = user_id OR is_imprint_admin('fiamma'))
WITH CHECK (auth.uid() = user_id OR is_imprint_admin('fiamma'));
