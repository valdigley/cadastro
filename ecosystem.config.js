module.exports = {
  apps: [{
    name: 'cliente-interface',
    script: 'npx',
    args: 'serve -s dist -l 3000',
    cwd: '/var/www/cliente-interface',
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
    env: {
      NODE_ENV: 'production'
    }
  }]
}