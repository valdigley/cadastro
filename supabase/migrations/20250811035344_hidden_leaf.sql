/*
  # Add RLS policies for clients table

  1. Security
    - Add INSERT policy for authenticated users to create clients
    - Add SELECT policy for users to read their own clients
    - Add UPDATE policy for users to update their own clients
    - Add DELETE policy for users to delete their own clients

  This migration adds the necessary Row Level Security policies to allow
  authenticated users to manage their client records.
*/

-- Add INSERT policy for authenticated users
CREATE POLICY "clients_insert_policy"
  ON clients
  FOR INSERT
  TO authenticated
  WITH CHECK (photographer_id IN (
    SELECT id FROM photographers WHERE user_id = auth.uid()
  ));

-- Add SELECT policy for users to read their own clients
CREATE POLICY "clients_select_policy"
  ON clients
  FOR SELECT
  TO authenticated
  USING (photographer_id IN (
    SELECT id FROM photographers WHERE user_id = auth.uid()
  ));

-- Add UPDATE policy for users to update their own clients
CREATE POLICY "clients_update_policy"
  ON clients
  FOR UPDATE
  TO authenticated
  USING (photographer_id IN (
    SELECT id FROM photographers WHERE user_id = auth.uid()
  ))
  WITH CHECK (photographer_id IN (
    SELECT id FROM photographers WHERE user_id = auth.uid()
  ));

-- Add DELETE policy for users to delete their own clients
CREATE POLICY "clients_delete_policy"
  ON clients
  FOR DELETE
  TO authenticated
  USING (photographer_id IN (
    SELECT id FROM photographers WHERE user_id = auth.uid()
  ));