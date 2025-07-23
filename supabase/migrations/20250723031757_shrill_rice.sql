/*
  # Criar tabela de clientes

  1. Nova Tabela
    - `clients` - Tabela principal para armazenar dados dos clientes
      - `id` (uuid, chave primária)
      - `name` (text, nome completo do cliente)
      - `email` (text, email único do cliente)
      - `phone` (text, telefone do cliente)
      - `company` (text, empresa do cliente - opcional)
      - `address` (text, endereço completo - opcional)
      - `notes` (text, observações sobre o cliente - opcional)
      - `user_id` (uuid, referência ao usuário que criou o cliente)
      - `created_at` (timestamp, data de criação)
      - `updated_at` (timestamp, data de atualização)

  2. Segurança
    - Habilitar RLS na tabela `clients`
    - Política para usuários autenticados lerem apenas seus próprios clientes
    - Política para usuários autenticados criarem clientes
    - Política para usuários autenticados atualizarem seus próprios clientes
    - Política para usuários autenticados excluírem seus próprios clientes

  3. Índices
    - Índice no campo `user_id` para consultas eficientes
    - Índice no campo `email` para buscas rápidas
*/

CREATE TABLE IF NOT EXISTS clients (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text NOT NULL,
  phone text DEFAULT '',
  company text DEFAULT '',
  address text DEFAULT '',
  notes text DEFAULT '',
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Habilitar RLS
ALTER TABLE clients ENABLE ROW LEVEL SECURITY;

-- Políticas RLS
CREATE POLICY "Users can read own clients"
  ON clients
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create clients"
  ON clients
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own clients"
  ON clients
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own clients"
  ON clients
  FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_clients_user_id ON clients(user_id);
CREATE INDEX IF NOT EXISTS idx_clients_email ON clients(email);

-- Trigger para atualizar updated_at automaticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_clients_updated_at
    BEFORE UPDATE ON clients
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();