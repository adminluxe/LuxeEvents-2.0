#!/bin/bash

echo "🚀 Déploiement LuxeEvents en cours..."

# Assure-toi d'être connecté à Vercel
if ! command -v vercel &> /dev/null; then
  echo "❌ Vercel CLI non trouvée. Installation..."
  npm install -g vercel
fi

# Déploiement forcé
vercel --prod --force || {
  echo "❌ Échec du déploiement. Vérifie la config Vercel ou les logs."
  exit 1
}

echo "✅ LuxeEvents déployé avec succès ! 🔥"
