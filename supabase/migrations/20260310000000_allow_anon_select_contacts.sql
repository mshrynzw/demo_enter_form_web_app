/*
  # Allow anonymous users to view contacts (for admin dashboard without auth)

  This migration adds a policy so that anonymous users can SELECT from contacts.
  Use this for demo apps where admin authentication is not yet implemented.

  For production: Remove this policy and implement Supabase Auth for admin access.
*/

-- Policy: Allow anonymous users to view all contacts (for admin dashboard demo)
CREATE POLICY "Anonymous users can view all contacts"
  ON contacts
  FOR SELECT
  TO anon
  USING (true);
