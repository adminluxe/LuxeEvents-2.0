#!/usr/bin/env bash
set -euo pipefail

echo "🧪 Démarrage du setup PWA+ Immersive Ultimate…"

# 1) Enrichir manifest.json
echo "1) Mise à jour de public/manifest.json…"
jq '
  .scope="\/" |
  .display="standalone" |
  .shortcuts = [
    {name:"Prestations",url:"/prestations",icons:[{src:"/icons/icon-192.png",sizes:"192x192"}]},
    {name:"Contact",    url:"/contact",     icons:[{src:"/icons/icon-192.png",sizes:"192x192"}]}
  ] |
  .icons += [
    {src:"/icons/splash-640x1136.png",sizes:"640x1136",type:"image/png"},
    {src:"/icons/splash-750x1334.png",sizes:"750x1334",type:"image/png"},
    {src:"/icons/splash-1242x2208.png",sizes:"1242x2208",type:"image/png"}
  ]
' public/manifest.json > public/manifest.tmp.json && mv public/manifest.tmp.json public/manifest.json

# 2) Créer les splash screens placeholders
echo "2) Création de placeholders splash screens…"
mkdir -p public/icons
for size in 640x1136 750x1334 1242x2208; do
  curl -sLo public/icons/splash-$size.png https://via.placeholder.com/${size}.png
done

# 3) Offline fallback page
echo "3) Ajout de public/offline.html…"
tee public/offline.html > /dev/null << 'EOF'
<!DOCTYPE html>
<html lang="fr">
<head><meta charset="UTF-8"><title>Hors ligne</title></head>
<body style="display:flex;align-items:center;justify-content:center;height:100vh;">
  <div style="text-align:center;">
    <h1>Oh oh… Vous êtes hors ligne !</h1>
    <p>Mais ne vous inquiétez pas, l’Exception vous attend dès que vous reviendrez.</p>
    <button onclick="location.reload()" style="padding:1em 2em;background:#D4AF37;border:none;border-radius:8px;color:white;">
      Réessayer
    </button>
  </div>
</body>
</html>
EOF

# 4) Configurer Workbox fallback dans build-sw.cjs
echo "4) Mise à jour de build-sw.cjs pour navigateFallback…"
perl -i -pe '
  s|(generateSW\(\{)|$1
  ,  navigateFallback: "/offline.html"
  ,  navigateFallbackAllowlist: [/,^\\/$/]
  ,  skipWaiting: true
  ,  clientsClaim: true|s;
' build-sw.cjs

# 5) Installer web-push et générer clés VAPID
echo "5) Installation de web-push et génération des clés VAPID…"
npm install web-push --save
tee generate-vapid-keys.js > /dev/null << 'EOF'
import webpush from 'web-push';
const vapidKeys = webpush.generateVAPIDKeys();
console.log('VAPID_PUBLIC_KEY=' + vapidKeys.publicKey);
console.log('VAPID_PRIVATE_KEY=' + vapidKeys.privateKey);
EOF
node -r esm generate-vapid-keys.js > vapid-keys.txt
echo "→ Tes clés VAPID sont dans vapid-keys.txt"

# 6) Créer un service worker push-ready
echo "6) Création de src/service-worker-push.js…"
tee src/service-worker-push.js > /dev/null << 'EOF'
self.addEventListener('push', event => {
  const data = event.data.json();
  event.waitUntil(
    self.registration.showNotification(data.title, {
      body: data.body,
      icon: data.icon || '/icons/icon-192.png'
    })
  );
});
EOF
# Injecter dans vite.config.js
perl -i -0777 -pe '
  s|(import { VitePWA }[^\n]*\n)|$1  workbox: { swSrc: "src/service-worker-push.js" },\n|s;
' vite.config.js

# 7) Intégrer Lighthouse CI
echo "7) Installation de @lhci/cli et création du workflow…"
npm install @lhci/cli --save-dev
mkdir -p .github/workflows
tee .github/workflows/lighthouse.yml > /dev/null << 'EOF'
name: Lighthouse CI

on:
  pull_request:

jobs:
  lighthouse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: pnpm/action-setup@v2
        with:
          node-version: '18'
      - run: npm install
      - run: npm run build && npm run postbuild
      - run: npx lhci autorun --upload.target=temporary-public-storage
EOF

echo "✅ PWA+ setup terminé !"
echo "→ Maintenant :"
echo "   npm run build && npm run postbuild"
echo "   sed -i 's|%PUBLIC_URL%||g' dist/index.html"
echo "   npx serve dist"
