## Como Criar o Arquivo ZIP para Deploy no EasyPanel

### Passo a Passo:

#### 1. Arquivos que DEVEM estar incluídos no ZIP:
```
cliente-interface.zip
├── src/
│   ├── components/
│   │   ├── AuthForm.tsx
│   │   ├── ClientCard.tsx
│   │   ├── ClientForm.tsx
│   │   └── ClientsList.tsx
│   ├── hooks/
│   │   └── useAuth.tsx
│   ├── lib/
│   │   └── supabase.ts
│   ├── App.tsx
│   ├── main.tsx
│   ├── index.css
│   └── vite-env.d.ts
├── index.html
├── package.json
├── package-lock.json
├── tsconfig.json
├── tsconfig.node.json
├── vite.config.ts
├── tailwind.config.js
├── postcss.config.js
├── Dockerfile
├── nginx-easypanel.conf
├── .dockerignore
└── .env
```

#### 2. Arquivos que NÃO devem estar incluídos:
- ❌ `node_modules/` (pasta)
- ❌ `dist/` (pasta)
- ❌ `.git/` (pasta)
- ❌ `*.log` (arquivos de log)
- ❌ `.DS_Store` (macOS)
- ❌ `Thumbs.db` (Windows)

### Como criar o ZIP:

#### No Windows:
1. Selecione todos os arquivos necessários (CTRL+A, depois desmarque as pastas proibidas)
2. Clique com botão direito → "Enviar para" → "Pasta compactada"
3. Renomeie para `cliente-interface.zip`

#### No macOS:
1. Selecione todos os arquivos necessários
2. Clique com botão direito → "Compactar itens"
3. Renomeie para `cliente-interface.zip`

#### No Linux:
```bash
# Na pasta do projeto
zip -r cliente-interface.zip . -x "node_modules/*" "dist/*" ".git/*" "*.log"
```

### Verificar o ZIP antes do upload:
Antes de fazer upload no EasyPanel, abra o ZIP e verifique:
- ✅ Pasta `src/` com todos os componentes
- ✅ Arquivo `Dockerfile` na raiz
- ✅ Arquivo `package.json` na raiz
- ✅ Arquivo `.env` com as variáveis do Supabase
- ✅ Não há pasta `node_modules`
- ✅ Tamanho do arquivo entre 1-5 MB

### No EasyPanel:

1. **Acesse seu painel EasyPanel**
2. **Clique em "Create App"**
3. **Escolha "Upload ZIP"**
4. **Faça upload do arquivo `cliente-interface.zip`**
5. **Configure a aplicação:**
   - **Name**: `cliente-interface`
   - **Build Method**: `Docker`
   - **Dockerfile Path**: `./Dockerfile`
   - **Port**: `80`

6. **Adicione as Variáveis de Ambiente:**
```
VITE_SUPABASE_URL=https://iisejjtimakkwjrbmzvj.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlpc2VqanRpbWFra3dqcmJtenZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcyNjg1MzEsImV4cCI6MjA2Mjg0NDUzMX0.f14s_dLEep9oq6JNVtpMltQkz_O8MsLXO0K2M1G1qIU
```

7. **Clique em "Deploy"**
8. **Aguarde o build completar**

### Dicas importantes:
- 📦 **Tamanho**: O ZIP deve ter entre 1-5 MB (sem node_modules)
- ⚡ **Velocidade**: Upload via ZIP é mais rápido que Git
- 🔄 **Atualizações**: Para atualizar, crie um novo ZIP e faça upload
- 🛡️ **Segurança**: Nunca inclua senhas ou chaves privadas no ZIP

### Troubleshooting:
- **ZIP muito grande?** Verifique se não incluiu `node_modules` ou `dist`
- **Erro de build?** Confirme se o `Dockerfile` está na raiz do ZIP
- **App não carrega?** Verifique se as variáveis de ambiente estão corretas