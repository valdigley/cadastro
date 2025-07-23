# Deploy no EasyPanel - Guia Completo

## Pré-requisitos

1. Conta no EasyPanel
2. VPS configurada com EasyPanel instalado
3. Código da aplicação em um repositório Git OU arquivo ZIP

## Passos para Deploy

### Opção 1: Deploy via Arquivo ZIP (Mais Simples)

1. **Preparar o arquivo ZIP**
   - Compacte todos os arquivos do projeto (incluindo Dockerfile)
   - Certifique-se de incluir: `package.json`, `Dockerfile`, `nginx-easypanel.conf`, pasta `src/`, etc.
   - **NÃO inclua**: `node_modules`, `.git`

2. **No EasyPanel**
   - Clique em "Create App"
   - Escolha "Upload ZIP"
   - Faça upload do seu arquivo ZIP

3. **Configurar a Aplicação**
   - **Name**: `cliente-interface`
   - **Build Method**: `Docker`
   - **Dockerfile Path**: `./Dockerfile`
   - **Port**: `80`

4. **Adicionar Variáveis de Ambiente**:
```
VITE_SUPABASE_URL=https://iisejjtimakkwjrbmzvj.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlpc2VqanRpbWFra3dqcmJtenZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcyNjg1MzEsImV4cCI6MjA2Mjg0NDUzMX0.f14s_dLEep9oq6JNVtpMltQkz_O8MsLXO0K2M1G1qIU
```

5. **Deploy**
   - Clique em "Deploy"
   - Aguarde o build completar

### Opção 2: Deploy via Git (Para atualizações automáticas)

### 1. Preparar o Repositório

Certifique-se de que os seguintes arquivos estão no seu repositório:
- `Dockerfile`
- `nginx-easypanel.conf`
- `.dockerignore`
- Todos os arquivos da aplicação React

### 2. Criar Aplicação no EasyPanel

1. **Acesse o painel do EasyPanel**
2. **Clique em "Create App"**
3. **Escolha "From Source Code"**

### 3. Configurar a Aplicação

#### Configurações Básicas:
- **Name**: `cliente-interface` (ou nome de sua escolha)
- **Repository**: URL do seu repositório Git
- **Branch**: `main` ou `master`
- **Build Path**: `/` (raiz do projeto)

#### Configurações de Build:
- **Build Method**: `Docker`
- **Dockerfile Path**: `./Dockerfile`
- **Port**: `80`

#### Variáveis de Ambiente:
Adicione as seguintes variáveis de ambiente:

```
VITE_SUPABASE_URL=https://iisejjtimakkwjrbmzvj.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlpc2VqanRpbWFra3dqcmJtenZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcyNjg1MzEsImV4cCI6MjA2Mjg0NDUzMX0.f14s_dLEep9oq6JNVtpMltQkz_O8MsLXO0K2M1G1qIU
```

### 4. Configurar Domínio (Opcional)

1. **Na aba "Domains"**
2. **Adicione seu domínio personalizado**
3. **Configure SSL automático**

### 5. Deploy

1. **Clique em "Deploy"**
2. **Aguarde o build completar**
3. **Acesse a aplicação através da URL fornecida**

## Vantagens do EasyPanel

✅ **Interface visual simples**
✅ **Deploy automático via Git**
✅ **SSL automático**
✅ **Monitoramento integrado**
✅ **Logs em tempo real**
✅ **Backup automático**
✅ **Rollback fácil**

## Configurações Avançadas

### Auto Deploy
- Habilite "Auto Deploy" para fazer deploy automático a cada push no repositório

### Health Checks
- Configure health checks para monitorar a saúde da aplicação

### Recursos
- **CPU**: 0.5 vCPU (ajuste conforme necessário)
- **RAM**: 512MB (ajuste conforme necessário)
- **Storage**: 1GB (suficiente para aplicação React)

## Comandos Úteis no EasyPanel

### Ver Logs
- Acesse a aba "Logs" no painel da aplicação

### Restart da Aplicação
- Clique em "Restart" no painel

### Rebuild
- Clique em "Rebuild" para fazer novo build

## Troubleshooting

### Aplicação não carrega
1. Verifique os logs na aba "Logs"
2. Confirme se as variáveis de ambiente estão corretas
3. Verifique se o Dockerfile está correto

### Erro de build
1. Verifique se todos os arquivos estão no repositório
2. Confirme se o `package.json` está correto
3. Verifique os logs de build

### Problemas de rota (404 em rotas do React)
- Confirme se o `nginx-easypanel.conf` está configurado corretamente
- Verifique se a configuração SPA está ativa

## Atualizações

### Via ZIP:
1. Faça as mudanças no código
2. Crie um novo arquivo ZIP
3. No EasyPanel, vá em "Settings" → "Source"
4. Faça upload do novo ZIP
5. Clique em "Deploy"

### Via Git:
Para atualizar a aplicação:
1. Faça push das mudanças para o repositório
2. Se auto-deploy estiver ativo, o deploy será automático
3. Caso contrário, clique em "Deploy" no painel

## Monitoramento

O EasyPanel oferece:
- **Métricas de CPU e RAM**
- **Logs em tempo real**
- **Status da aplicação**
- **Histórico de deploys**

## Backup e Rollback

- **Backup**: Automático via Git
- **Rollback**: Selecione um commit anterior e faça redeploy

## Custos

O EasyPanel geralmente cobra por:
- **Recursos utilizados** (CPU, RAM, Storage)
- **Tráfego** (bandwidth)
- **Número de aplicações**

Consulte a documentação oficial do EasyPanel para preços atualizados.