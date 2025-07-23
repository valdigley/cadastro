# Deploy na VPS - Guia Completo

## Pré-requisitos na VPS

### 1. Instalar Node.js e npm
```bash
# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verificar instalação
node --version
npm --version
```

### 2. Instalar PM2 (Process Manager)
```bash
sudo npm install -g pm2
```

### 3. Instalar Nginx
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install nginx

# Iniciar e habilitar nginx
sudo systemctl start nginx
sudo systemctl enable nginx
```

### 4. Instalar serve (para servir arquivos estáticos)
```bash
sudo npm install -g serve
```

## Passos para Deploy

### 1. Preparar o código na sua máquina local
```bash
# Construir a aplicação
npm run build

# Compactar os arquivos
tar -czf cliente-interface.tar.gz dist/ package.json ecosystem.config.js
```

### 2. Enviar arquivos para a VPS
```bash
# Via SCP
scp cliente-interface.tar.gz usuario@seu-servidor:/tmp/

# Via rsync (alternativa)
rsync -avz dist/ usuario@seu-servidor:/var/www/cliente-interface/
```

### 3. Na VPS, extrair e configurar
```bash
# Conectar na VPS
ssh usuario@seu-servidor

# Criar diretório da aplicação
sudo mkdir -p /var/www/cliente-interface
cd /var/www/cliente-interface

# Extrair arquivos
sudo tar -xzf /tmp/cliente-interface.tar.gz

# Configurar permissões
sudo chown -R www-data:www-data /var/www/cliente-interface
sudo chmod -R 755 /var/www/cliente-interface
```

### 4. Configurar Nginx
```bash
# Copiar configuração do nginx
sudo cp nginx.conf /etc/nginx/sites-available/cliente-interface

# Criar link simbólico
sudo ln -s /etc/nginx/sites-available/cliente-interface /etc/nginx/sites-enabled/

# Remover configuração padrão (opcional)
sudo rm /etc/nginx/sites-enabled/default

# Testar configuração
sudo nginx -t

# Reiniciar nginx
sudo systemctl reload nginx
```

### 5. Iniciar aplicação com PM2
```bash
cd /var/www/cliente-interface
sudo pm2 start ecosystem.config.js
sudo pm2 save
sudo pm2 startup
```

## Configuração de Domínio

### 1. Apontar domínio para VPS
- Configure os DNS do seu domínio para apontar para o IP da VPS
- Aguarde a propagação (pode levar até 24h)

### 2. Configurar SSL (HTTPS) - Opcional mas recomendado
```bash
# Instalar Certbot
sudo apt install certbot python3-certbot-nginx

# Obter certificado SSL
sudo certbot --nginx -d seu-dominio.com

# Renovação automática
sudo crontab -e
# Adicionar linha: 0 12 * * * /usr/bin/certbot renew --quiet
```

## Comandos Úteis

### Verificar status da aplicação
```bash
sudo pm2 status
sudo pm2 logs cliente-interface
```

### Reiniciar aplicação
```bash
sudo pm2 restart cliente-interface
```

### Verificar logs do Nginx
```bash
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

### Atualizar aplicação
```bash
# Parar aplicação
sudo pm2 stop cliente-interface

# Fazer backup
sudo mv /var/www/cliente-interface/dist /var/www/cliente-interface/dist_backup

# Copiar nova versão
# ... (repetir passos de deploy)

# Reiniciar
sudo pm2 start cliente-interface
```

## Variáveis de Ambiente

Certifique-se de que as variáveis do Supabase estejam configuradas:

```bash
# Criar arquivo .env na VPS
sudo nano /var/www/cliente-interface/.env

# Adicionar:
VITE_SUPABASE_URL=https://iisejjtimakkwjrbmzvj.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlpc2VqanRpbWFra3dqcmJtenZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcyNjg1MzEsImV4cCI6MjA2Mjg0NDUzMX0.f14s_dLEep9oq6JNVtpMltQkz_O8MsLXO0K2M1G1qIU
```

## Firewall (se necessário)
```bash
# Permitir HTTP e HTTPS
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow ssh
sudo ufw enable
```

## Troubleshooting

### Aplicação não carrega
1. Verificar se PM2 está rodando: `sudo pm2 status`
2. Verificar logs: `sudo pm2 logs cliente-interface`
3. Verificar se Nginx está rodando: `sudo systemctl status nginx`

### Erro 502 Bad Gateway
1. Verificar se a aplicação está rodando na porta correta
2. Verificar configuração do Nginx
3. Verificar logs do Nginx

### Problemas de permissão
```bash
sudo chown -R www-data:www-data /var/www/cliente-interface
sudo chmod -R 755 /var/www/cliente-interface
```