#!/bin/bash

echo "🔎 Dernière passe : suppression des traces VISIBLE dans tout le rendu JSX..."

# Supprimer les lignes contenant VISIBLE: en tant que contenu JSX ou texte
find ./src -type f \( -name "*.jsx" -o -name "*.tsx" \) \
  -exec sed -i '/VISIBLE:.*<\/[a-z]*>/d' {} + \
  -exec sed -i '/VISIBLE:.*\/>/d' {} + \
  -exec sed -i '/VISIBLE:/d' {} +

# Nettoyer aussi tous les "return VISIBLE" ou fragments contenant uniquement ce texte
find ./src -type f \( -name "*.jsx" -o -name "*.tsx" \) \
  -exec sed -i 's/return.*VISIBLE.*//g' {} + \
  -exec sed -i 's/<>VISIBLE:.*<\/>//g' {} +

echo "✅ Tous les tags VISIBLE ont été effacés. Rebuild en cours..."

npm run build || {
  echo "❌ Build échoué. Reste un bug."
  exit 1
}

echo "🚀 Re-déploiement clean..."
vercel --prod --force || {
  echo "❌ Échec du déploiement. Vérifie la connexion ou le compte Vercel."
  exit 1
}

echo "🎉 FINI POUR DE VRAI TONTON. VISIBLE est MORT. 🪦"
