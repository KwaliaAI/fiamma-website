CREATE TABLE IF NOT EXISTS public.fiamma_books (
  title_id       text PRIMARY KEY,
  title          text NOT NULL,
  slug           text NOT NULL UNIQUE,
  heteronym      text NOT NULL,
  genre          text NOT NULL DEFAULT 'Romance',
  fiamma_line    text,
  blurb_short    text,
  blurb_300      text,
  cover_url      text,
  isbn_pb        text,
  isbn_eb        text,
  isbn_audio     text,
  buy_url_amazon text,
  buy_url_ebook  text,
  buy_url_audio  text,
  series_order   integer,
  visible        boolean NOT NULL DEFAULT false,
  created_at     timestamptz NOT NULL DEFAULT now(),
  updated_at     timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.fiamma_books ENABLE ROW LEVEL SECURITY;

CREATE POLICY "fiamma books public read"
ON public.fiamma_books FOR SELECT
TO anon, authenticated
USING (visible = true);

CREATE POLICY "fiamma books admin all"
ON public.fiamma_books FOR ALL
TO authenticated
USING (is_imprint_admin('fiamma'))
WITH CHECK (is_imprint_admin('fiamma'));
