/*
  # Add missing columns to clients table

  1. Changes
    - Add `company` column (text, nullable)
    - Add `address` column (text, nullable)
  
  2. Security
    - No changes to existing RLS policies needed
*/

-- Add missing columns to clients table
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'clients' AND column_name = 'company'
  ) THEN
    ALTER TABLE clients ADD COLUMN company text;
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'clients' AND column_name = 'address'
  ) THEN
    ALTER TABLE clients ADD COLUMN address text;
  END IF;
END $$;