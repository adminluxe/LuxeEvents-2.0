#!/bin/bash

set -e

echo "🔐 Initialisation commit Git..."
git add .
git commit -m "🚀 Mise en ligne officielle de LuxeEvents V1"
git push origin main

echo "🛠️  Build du projet..."
npm run build

echo "🚀 Déploiement sur Vercel (prod)..."
vercel --prod --confirm > .deploy-url.log

echo "🌐 URL déployée :"
grep -oE 'https://[^ ]+\.vercel\.app' .deploy-url.log

echo "🌍 Ouverture dans le navigateur..."
xdg-open "$(grep -oE 'https://[^ ]+\.vercel\.app' .deploy-url.log)" 2>/dev/null || open "$(grep -oE 'https://[^ ]+\.vercel\.app' .deploy-url.log)"

echo "✅ LuxeEvents V1 est en ligne, félicitations ✨"
