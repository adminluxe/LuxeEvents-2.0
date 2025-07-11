#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# 0) Où tourner ton SSR ? (défaut 8000)
PORT=${SSR_PORT:-8000}

echo "🌱 0) Backup de vite.config.js…"
[ -f vite.config.js ] && cp vite.config.js vite.config.js.bak

echo "🔧 1) Augmentation inotify watchers…"
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=8192
grep -qxF "fs.inotify.max_user_watches=524288" /etc/sysctl.conf \
  || echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
grep -qxF "fs.inotify.max_user_instances=8192" /etc/sysctl.conf \
  || echo "fs.inotify.max_user_instances=8192" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "✏️ 2) Reset vite.config.js…"
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
    VitePWA({ /* ta config PWA */ })
  ],
  ssr: { noExternal: ['react-router-dom'] },
  base: '/'
})
EOF
echo "✓ vite.config.js prêt"

echo "🛠 3) Dependencies & build…"
pnpm install express@4
pnpm install
pnpm build

echo "🔍 4) Vérif server.js…"
if [ ! -f server.js ]; then
  echo "❌ Pas de server.js trouvé. Arrêt."
  exit 1
fi

echo "🚀 5) Lancement SSR sur port $PORT…"
# on capture stdout+stderr
LOGFILE=ssr.log
node server.js >"$LOGFILE" 2>&1 &
SSR_PID=$!
sleep 2

if nc -z localhost "$PORT"; then
  echo "✅ SSR OK sur http://localhost:$PORT (PID=$SSR_PID)"
  echo "   Pour voir les logs : tail -n 30 $LOGFILE"
  echo "   Pour stopper : kill $SSR_PID"
else
  echo "❌ SSR n'écoute pas sur le port $PORT"
  echo "   → Vérifie le log (${LOGFILE}), dernières lignes :"
  tail -n 20 "$LOGFILE"
  exit 1
fi
