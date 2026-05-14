-- Canonicalize Mud Season's reader DB identity after Ellie Marsh -> Hailey Boone.
-- Reader routes use localFiammaBooks.title_id for unlocks/progress, so the live
-- fiamma_books primary key must match the canonical local title_id.

UPDATE public.fiamma_books
SET slug = 'mud-season-legacy-ellie-marsh',
    visible = false,
    updated_at = now()
WHERE title_id = 'ellie-marsh-001-mud-season';

INSERT INTO public.fiamma_books (
  title_id,
  title,
  slug,
  heteronym,
  genre,
  fiamma_line,
  blurb_short,
  blurb_300,
  cover_url,
  isbn_pb,
  isbn_eb,
  isbn_audio,
  series_order,
  visible
)
VALUES (
  'hailey-boone-001-mud-season',
  'Mud Season',
  'mud-season',
  'Hailey Boone',
  'Romance',
  'Contemporary',
  'Juniper McClaren flew to Montana to close an estate, not to fall in love with the man on the porch. Three weeks to sell her grandfather''s ranch. One foreman who fills a doorway, keeps a list of every small thing she pretends to know, and has a hand that already knows where a dog''s shoulder is. She makes it thirty yards in grey heels before the mud takes both shoes. He doesn''t come meet her halfway.',
  'Juniper McClaren flew to Montana to close an estate, not to fall in love with the man on the porch.\n\nSeattle litigator, eleven months unclaimed, twenty-one days to bury a grandfather she never knew - June arrives at McClaren Ranch in grey heels and a pantsuit and walks across thirty yards of April mud in her socks because the man at the top of the steps is not going to meet her halfway.\n\nWyatt Reeves runs the ranch and fills a doorway. He keeps a list, in his head, of every small thing she pretends to know.\n\nFor three weeks they fight about a cow and make up in a tack room. They kiss at a kitchen sink with grass still in her hair. He almost tells her what he wants, and she almost stays, and then a bank statement at the back of a mudroom cabinet blows it all apart.\n\nWhen she drunk-texts him I HATE YOU from an airport bar in a blizzard, he drives two hundred miles through a late-April whiteout to carry her home.\n\nBook one of Hailey Boone''s Paradise Valley - for readers of Kristen Ashley, Maisey Yates, and Lauren Landish. Fun, hot, and honest about what it costs to let someone hand you the truth on a Tuesday.',
  '/assets/covers/mud-season.jpg',
  '978-1-917717-44-1',
  '978-1-917717-45-8',
  null,
  1,
  true
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
  series_order = EXCLUDED.series_order,
  visible = EXCLUDED.visible,
  updated_at = now();

INSERT INTO public.fiamma_book_unlocks (user_id, book_id, unlocked_at, is_gift_unlock)
SELECT
  user_id,
  'hailey-boone-001-mud-season',
  unlocked_at,
  is_gift_unlock
FROM public.fiamma_book_unlocks
WHERE book_id = 'ellie-marsh-001-mud-season'
ON CONFLICT (user_id, book_id) DO UPDATE SET
  unlocked_at = LEAST(public.fiamma_book_unlocks.unlocked_at, EXCLUDED.unlocked_at),
  is_gift_unlock = public.fiamma_book_unlocks.is_gift_unlock OR EXCLUDED.is_gift_unlock;

INSERT INTO public.fiamma_reading_progress (user_id, book_id, last_chapter, completed, updated_at)
SELECT
  user_id,
  'hailey-boone-001-mud-season',
  last_chapter,
  completed,
  updated_at
FROM public.fiamma_reading_progress
WHERE book_id = 'ellie-marsh-001-mud-season'
ON CONFLICT (user_id, book_id) DO UPDATE SET
  last_chapter = GREATEST(public.fiamma_reading_progress.last_chapter, EXCLUDED.last_chapter),
  completed = public.fiamma_reading_progress.completed OR EXCLUDED.completed,
  updated_at = GREATEST(public.fiamma_reading_progress.updated_at, EXCLUDED.updated_at);

DELETE FROM public.fiamma_book_unlocks
WHERE book_id = 'ellie-marsh-001-mud-season';

DELETE FROM public.fiamma_reading_progress
WHERE book_id = 'ellie-marsh-001-mud-season';

DELETE FROM public.fiamma_books
WHERE title_id = 'ellie-marsh-001-mud-season';
