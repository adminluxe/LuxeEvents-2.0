#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Port sur lequel ton server.js écoute
PORT=${SSR_PORT:-8000}
LOGFILE=ssr.log

echo "🌱 0) Sauvegarde de vite.config.js…"
[ -f vite.config.js ] && cp vite.config.js vite.config.js.bak

echo "🔧 1) On gonfle les inotify watchers…"
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=8192
grep -qxF "fs.inotify.max_user_watches=524288" /etc/sysctl.conf \
  || echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
grep -qxF "fs.inotify.max_user_instances=8192" /etc/sysctl.conf \
  || echo "fs.inotify.max_user_instances=8192" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "✏️ 2) On rebâtit vite.config.js en one-and-only export…"
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import ssr from 'vite-plugin-ssr/plugin'
import { VitePWA } from 'vite-plugin-pwa'

export default defineConfig({
  server: {
    middlewareMode: true,
    watch: false,
    host: true,
    port: 5173,
    strictPort: true
  },
  plugins: [
    react(),
    ssr(),
    VitePWA({ /* ta config PWA ici */ })
  ],
  ssr: { noExternal: ['react-router-dom'] },
  base: '/'
})
EOF
echo "✓ vite.config.js est sain comme un nouveau-né"

echo "🛠 3) Installation des dépendances & build…"
pnpm install express@4
pnpm install
pnpm build

echo "🔍 4) On vérifie que server.js existe…"
if [ ! -f server.js ]; then
  echo "❌ Oups, pas de server.js ! Crée-le selon la doc SSR."
  exit 1
fi

echo "🚀 5) Démarrage du SSR (logs dans ${LOGFILE})…"
# Lance et capture tout
nohup node server.js >"$LOGFILE" 2>&1 &
SSR_PID=$!
echo "   → PID=$SSR_PID"

# Attente progressive jusqu'à 5s max
echo "⏳ On attend que le port ${PORT} écoute…"
for i in {1..5}; do
  if nc -z localhost "$PORT"; then
    echo "✅ Ton SSR est UP sur http://localhost:${PORT} (en ${i}s)"
    echo "   Pour suivre les logs : tail -f ${LOGFILE}"
    echo "   Pour arrêter : kill ${SSR_PID}"
    exit 0
  fi
  sleep 1
done

echo "❌ Toujours pas de port à l’écoute après 5 s."
echo "   Voici les 20 dernières lignes du log (${LOGFILE}) :"
tail -n 20 "$LOGFILE"
exit 1
