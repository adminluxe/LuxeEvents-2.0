#!/bin/bash

echo "💣 Suppression des artefacts de cache potentiels..."

# 1. Supprimer le cache Vercel local (si présent)
rm -rf .vercel/cache dist .next .output node_modules/.vite

# 2. Nettoyage du cache Vite
npm run clean || rm -rf dist

# 3. Rebuild complet
echo "🔨 Rebuild Vite en mode clean..."
npm run build || {
  echo "❌ Build échoué. Abandon."
  exit 1
}

# 4. Déploiement Vercel forcé, sans cache
echo "🚀 Déploiement Vercel en purge totale..."
vercel --prod --force --no-clipboard --confirm || {
  echo "❌ Échec du déploiement. Check Vercel CLI."
  exit 1
}

echo "🧼 TERMINE : Vercel déployé sans cache. Force refresh avec CTRL+F5 si besoin."
