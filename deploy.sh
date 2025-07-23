#!/bin/bash

# Script de deploy para VPS
# Execute este script na sua VPS

echo "🚀 Iniciando deploy da aplicação..."

# Diretório da aplicação
APP_DIR="/var/www/cliente-interface"

# Criar diretório se não existir
sudo mkdir -p $APP_DIR

# Navegar para o diretório
cd $APP_DIR

# Fazer backup da versão anterior (se existir)
if [ -d "dist" ]; then
    echo "📦 Fazendo backup da versão anterior..."
    sudo mv dist dist_backup_$(date +%Y%m%d_%H%M%S)
fi

# Clonar ou atualizar o repositório (substitua pela URL do seu repositório)
# git clone https://github.com/seu-usuario/seu-repositorio.git .
# ou se já existe: git pull origin main

# Instalar dependências
echo "📥 Instalando dependências..."
npm install

# Construir a aplicação
echo "🔨 Construindo aplicação..."
npm run build

# Configurar permissões
sudo chown -R www-data:www-data $APP_DIR
sudo chmod -R 755 $APP_DIR

# Reiniciar serviços
echo "🔄 Reiniciando serviços..."
sudo systemctl reload nginx
sudo pm2 restart cliente-interface || sudo pm2 start ecosystem.config.js

echo "✅ Deploy concluído!"
echo "🌐 Aplicação disponível em: http://seu-dominio.com"