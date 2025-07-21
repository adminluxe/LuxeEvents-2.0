#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "🌱 0) Sauvegarde de l'existant…"
[ -f vite.config.js ] && cp vite.config.js vite.config.js.bak

echo "🔧 1) Augmentation des inotify watchers…"
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=8192
grep -qxF "fs.inotify.max_user_watches=524288" /etc/sysctl.conf \
  || echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
grep -qxF "fs.inotify.max_user_instances=8192" /etc/sysctl.conf \
  || echo "fs.inotify.max_user_instances=8192" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "✏️ 2) Reconstruction de vite.config.js…"
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import ssr from 'vite-plugin-ssr/plugin'
import { VitePWA } from 'vite-plugin-pwa'

export default defineConfig({
  server: {
    // mode middleware pour ton Express + SSR
    middlewareMode: true,
    // désactive totalement les watchers pour éviter ENOSPC
    watch: false,
    // tu peux toujours binder le host/port si besoin
    host: true,
    port: 5173,
    strictPort: true
  },
  plugins: [
    react(),
    ssr(),
    VitePWA({ /* ta config PWA ici */ })
  ],
  ssr: {
    noExternal: ['react-router-dom']
  },
  base: '/'
})
EOF
echo "✓ vite.config.js remis à plat (un seul export default defineConfig)"

echo "🛠 3) Installation des dépendances & build…"
pnpm install express@4             # force Express v4 si tu utilises path-to-regexp <8
pnpm install                       # le reste
pnpm build

echo "🔍 4) Vérification de server.js…"
if [ ! -f server.js ]; then
  echo "❌  server.js introuvable, crée-le selon la doc SSR avant de relancer."
  exit 1
fi

echo "🚀 5) Lancement du SSR sans watchers…"
node server.js &
SSR_PID=$!

# petit temps pour que le serveur monte
sleep 1

if ! nc -z localhost 8000; then
  echo "❌ Le SSR ne répond pas sur le port 8000, PID $SSR_PID"
  kill "$SSR_PID" 2>/dev/null || true
  exit 1
fi

echo "✅ SSR up et tournant sans ENOSPC (PID: $SSR_PID)"
echo
echo "👉 Pour stopper le SSR : kill $SSR_PID"
echo "🎉 Tu peux maintenant relancer ton deploy-final.sh sereinement."
