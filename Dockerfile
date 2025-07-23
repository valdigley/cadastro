FROM node:18-alpine as builder

WORKDIR /app

# Copiar package.json e package-lock.json
COPY package*.json ./

# Instalar dependências
RUN npm ci --only=production

# Copiar código fonte
COPY . .

# Construir aplicação
RUN npm run build

# Estágio de produção
FROM nginx:alpine

# Copiar arquivos construídos
COPY --from=builder /app/dist /usr/share/nginx/html

# Copiar configuração customizada do nginx
COPY nginx-easypanel.conf /etc/nginx/conf.d/default.conf

# Expor porta 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]