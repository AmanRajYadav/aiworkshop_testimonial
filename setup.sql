-- ============================================================
-- AI Workshop Testimonials — Run this once in Supabase SQL Editor
-- ============================================================

-- 1. Create testimonials table
CREATE TABLE IF NOT EXISTS testimonials (
  id          UUID          DEFAULT gen_random_uuid() PRIMARY KEY,
  name        TEXT          NOT NULL,
  feedback    TEXT          NOT NULL,
  photo_url   TEXT,
  rating      SMALLINT      CHECK (rating BETWEEN 1 AND 5),
  created_at  TIMESTAMPTZ   DEFAULT NOW()
);

-- 2. Enable Row Level Security
ALTER TABLE testimonials ENABLE ROW LEVEL SECURITY;

-- 3. Allow anyone to submit
CREATE POLICY "public_insert" ON testimonials
  FOR INSERT WITH CHECK (true);

-- 4. Allow anyone to view all testimonials
CREATE POLICY "public_select" ON testimonials
  FOR SELECT USING (true);

-- 5. Storage bucket (already created — just add policies)
CREATE POLICY "public_photo_upload" ON storage.objects
  FOR INSERT WITH CHECK (bucket_id = 'testimonial-photos');

CREATE POLICY "public_photo_read" ON storage.objects
  FOR SELECT USING (bucket_id = 'testimonial-photos');
