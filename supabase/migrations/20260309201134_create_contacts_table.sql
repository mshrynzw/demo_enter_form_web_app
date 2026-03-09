/*
  # Create Contacts Table

  1. New Tables
    - `contacts`
      - `id` (uuid, primary key) - Unique identifier for each contact
      - `name` (text, required) - Contact person's name
      - `email` (text, required) - Contact email address
      - `company` (text, optional) - Company name
      - `phone` (text, optional) - Contact phone number
      - `message` (text, required) - Message from contact
      - `created_at` (timestamptz) - Timestamp of contact submission

  2. Security
    - Enable RLS on `contacts` table
    - Add policy for anonymous users to insert their own contact data
    - Add policy for authenticated users to view all contacts (for admin dashboard)

  3. Notes
    - The form submission will be public (anonymous insert)
    - Only authenticated users can view the contacts list
    - Timestamps are automatically set on creation
*/

-- Create contacts table
CREATE TABLE IF NOT EXISTS contacts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text NOT NULL,
  company text DEFAULT '',
  phone text DEFAULT '',
  message text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;

-- Policy: Allow anonymous users to insert contacts (for form submission)
CREATE POLICY "Anyone can submit contact form"
  ON contacts
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Policy: Allow authenticated users to view all contacts (for admin dashboard)
CREATE POLICY "Authenticated users can view all contacts"
  ON contacts
  FOR SELECT
  TO authenticated
  USING (true);

-- Create an index on created_at for better performance on sorting
CREATE INDEX IF NOT EXISTS contacts_created_at_idx ON contacts(created_at DESC);