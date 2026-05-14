-- Seed launch-day Fiamma reader rows for Cold Snap and Wrong Side of the Ice.
-- The static site can show fallback books, but complimentary unlocks require
-- matching public.fiamma_books rows because fiamma_book_unlocks has an FK.

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
VALUES
  (
    'hailey-boone-004-cold-snap',
    'Cold Snap',
    'cold-snap',
    'Hailey Boone',
    'Romance',
    'Contemporary',
    'At the end of Galloway Road, Robin McKee''s mail truck is in a ditch, and a retired rodeo cowboy is about to become her warmest problem.',
    'At the end of Galloway Road, Robin McKee''s mail truck is in a ditch, her daughter''s daycare closes at five, and the man knocking on the window is too warm for the coldest week in fifteen years.\n\nRobin has been carrying mail through Paradise Valley since the divorce, since the move home, since the kid. She is good at being fine. She is less good at accepting help, especially from Wes Galloway, a retired saddle-bronc rider who has been back at his uncle''s boarding stable for nine days and already looks too much like shelter.\n\nWes pulls her truck out of the snow, hands her coffee, and keeps appearing at the end of her route with exactly what she refuses to ask for. Firewood. A plowed drive. Patience. By Christmas Eve, Robin''s furnace is dead, the cold snap is finally breaking, and the man she has spent twelve days resisting is the only warm place she wants to be.\n\nCold Snap is Paradise Valley book four: grumpy heroine, sunshine cowboy, single-mom stakes, slow-burn winter heat, and four explicit scenes for readers of Kristen Ashley, Maisey Yates, Lauren Landish, and Lyla Sage.',
    '/assets/covers/cold-snap.jpg',
    '978-1-917717-52-6',
    '978-1-917717-53-3',
    '978-1-917717-54-0',
    4,
    true
  ),
  (
    'casey-blake-001-wrong-side-of-the-ice',
    'Wrong Side of the Ice',
    'wrong-side-of-the-ice',
    'Casey Blake',
    'Romance',
    'Contemporary',
    'Nora Voss is supposed to clear Gabe Cahill for the semifinal, not fall for the transfer winger whose ankle she knows better than her own pulse.',
    'Nora Voss trusts files, pain scales, and what a player will not say when he says he is fine.\n\nGabe Cahill arrives at Hartwell University with a Grade II ankle sprain, a transfer file full of careful notes, and eleven days to prove he can play in the conference semifinal. Nora is the athletic trainer who can clear him or bench him. She is good at her job, precise with a tape roll, and very committed to not noticing the tall right wing who closes her training-room door like he already knows the rules.\n\nGabe is cooperative. Too cooperative. He answers every question except the one that matters: how much it really hurts when the skate comes off and nobody is watching. Nora knows better than to trust a charming athlete with a countdown clock. She knows much better than to touch him after hours.\n\nThen she does.\n\nNow the ankle is borderline, the clearance form is open, and Nora has to decide whether her judgment is still clean enough to sign her name to it. Wrong Side of the Ice is Hartwell University Hockey book one: college hockey, athletic-trainer competence, professional-conflict stakes, group-chat comedy, and four explicit scenes for readers of Hannah Grace, Elle Kennedy, Sarah Adams, and Mariana Zapata.',
    '/assets/covers/wrong-side-of-the-ice.jpg',
    '978-1-917717-55-7',
    '978-1-917717-56-4',
    '978-1-917717-57-1',
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
