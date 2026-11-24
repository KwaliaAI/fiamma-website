-- Dry Spell: approved Option A, ebook only; Apple Books US verified 24 Nov 2026.
-- Reader body is the unchanged signed v11 source in public/data/reader.
INSERT INTO public.fiamma_books (title_id, title, slug, heteronym, genre, fiamma_line, blurb_short, blurb_300, cover_url, isbn_pb, isbn_eb, isbn_audio, buy_url_amazon, buy_url_ebook, buy_url_audio, series_order, visible, created_at, updated_at)
VALUES (
  'hailey-boone-005-dry-spell',
  'Dry Spell',
  'dry-spell',
  'Hailey Boone',
  'Romance',
  'Contemporary',
  'Two good contracts. One barn.',
  'Lena Mercer has a hundred and forty wedding guests coming to a barn in Montana, and there''s hay machinery parked on the dance floor. It''s her first big job since she left the firm that trained her, and her old boss is the bride''s godmother.

There''s a man lying under the baler with a grease gun. "I''m going to need them moved," she says. "No," says Eli Brandt.

Eli leases the hay meadows, and the barn comes with them until the last cutting is stacked. Merrill Hollenback rented Lena the barn anyway, for ten days in August, and gave her peach pie about it.

They fight on the whiteboard in the barn office, his hay in black and her wedding in red. Their first kiss is up against it, and she walks out with his schedule printed backward across her white linen shirt. The first time they sleep together is in his tractor cab at one in the morning, and she knocks the wipers on across a bone-dry windshield. They leave them running.

It hasn''t rained since July, and now the radio says thunderstorms on the wedding day. His hay has to be cut, dried and under the roof before it rains, and it''s growing in the meadow Lena promised the bride for her aisle.

Dry Spell is book five in Hailey Boone''s Paradise Valley series, for readers of Kristen Ashley, Maisey Yates and Lyla Sage.',
  '/assets/covers/dry-spell.jpg',
  NULL,
  '9781917717922',
  NULL,
  NULL,
  'https://books.apple.com/us/book/dry-spell/id6837045349',
  NULL,
  5,
  TRUE,
  '2026-11-20T00:00:00Z',
  '2026-11-24T00:00:00Z'
)
ON CONFLICT (title_id) DO UPDATE SET
  title = EXCLUDED.title,
  slug = EXCLUDED.slug,
  heteronym = EXCLUDED.heteronym,
  genre = EXCLUDED.genre,
  fiamma_line = EXCLUDED.fiamma_line,
  blurb_short = EXCLUDED.blurb_short,
  blurb_300 = EXCLUDED.blurb_300,
  cover_url = EXCLUDED.cover_url,
  isbn_pb = EXCLUDED.isbn_pb,
  isbn_eb = EXCLUDED.isbn_eb,
  isbn_audio = EXCLUDED.isbn_audio,
  buy_url_amazon = EXCLUDED.buy_url_amazon,
  buy_url_ebook = EXCLUDED.buy_url_ebook,
  buy_url_audio = EXCLUDED.buy_url_audio,
  series_order = EXCLUDED.series_order,
  visible = EXCLUDED.visible,
  created_at = EXCLUDED.created_at,
  updated_at = EXCLUDED.updated_at;
