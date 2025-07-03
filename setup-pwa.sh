#!/usr/bin/env bash
set -euo pipefail

echo "🔌 Démarrage du setup PWA…"

# 1) Installer le plugin Vite PWA
echo "1) Installation de vite-plugin-pwa…"
npm install vite-plugin-pwa --save-dev

# 2) Générer manifest.json
echo "2) Création de public/manifest.json…"
tee public/manifest.json > /dev/null << 'EOF'
{
  "name": "LuxeEvents",
  "short_name": "LuxeEvents",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#D4AF37",
  "icons": [
    {
      "src": "/icons/icon-192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "/icons/icon-512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
EOF

# 3) Préparer les icons placeholders depuis placeholder.com
echo "3) Création des dossiers d'icônes et téléchargement de placeholders…"
mkdir -p public/icons
curl -sLo public/icons/icon-192.png https://via.placeholder.com/192.png
curl -sLo public/icons/icon-512.png https://via.placeholder.com/512.png

# 4) Patch vite.config.js
echo "4) Patch de vite.config.js pour Vite PWA…"
perl -i -0777 -pe '
  s|(import { defineConfig }.*\n)|$1import { VitePWA } from "vite-plugin-pwa"\n|;
  s|(plugins: \[react\(\)\])|plugins: \[react\(\), VitePWA\(\{ registerType: "autoUpdate", manifest: public\/manifest.json \}\)\]|s;
' vite.config.js

# 5) Service worker minimal
echo "5) Création de src/service-worker.js…"
tee src/service-worker.js > /dev/null << 'EOF'
self.addEventListener('message', (e) => {
  if (e.data && e.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});
EOF

echo "✅ Setup PWA terminé !"
echo "→ Relancez : npm run dev -- --host"
echo "→ Build & test offline : npm run build && npm run serve"

