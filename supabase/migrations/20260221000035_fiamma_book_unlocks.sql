CREATE TABLE IF NOT EXISTS public.fiamma_book_unlocks (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  book_id     text NOT NULL REFERENCES public.fiamma_books(title_id) ON DELETE CASCADE,
  unlocked_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, book_id)
);

CREATE INDEX IF NOT EXISTS idx_fiamma_book_unlocks_user ON public.fiamma_book_unlocks(user_id, unlocked_at DESC);
CREATE INDEX IF NOT EXISTS idx_fiamma_book_unlocks_book ON public.fiamma_book_unlocks(book_id);

ALTER TABLE public.fiamma_book_unlocks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "fiamma unlocks select"
ON public.fiamma_book_unlocks FOR SELECT
TO authenticated
USING (auth.uid() = user_id OR is_imprint_admin('fiamma'));

CREATE POLICY "fiamma unlocks insert"
ON public.fiamma_book_unlocks FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id OR is_imprint_admin('fiamma'));

CREATE POLICY "fiamma unlocks update"
ON public.fiamma_book_unlocks FOR UPDATE
TO authenticated
USING (auth.uid() = user_id OR is_imprint_admin('fiamma'))
WITH CHECK (auth.uid() = user_id OR is_imprint_admin('fiamma'));
