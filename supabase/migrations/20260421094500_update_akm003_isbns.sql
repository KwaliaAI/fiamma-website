UPDATE public.fiamma_books
SET
  isbn_pb = '978-1-917717-41-0',
  isbn_eb = '978-1-917717-42-7',
  isbn_audio = '978-1-917717-43-4',
  updated_at = now()
WHERE title_id = 'akm-003-base-notes';
