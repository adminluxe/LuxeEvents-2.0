#!/bin/bash

echo "🚿 Nettoyage TOTAL de LuxeEvents en cours... Patience Tonton, c'est pour la V1 propre..."

# Étape 1 – Suppression des blocs VISIBLE / TEST de debug
echo "🧹 Suppression des blocs de debug visibles..."
find ./src -type f -name "*.jsx" -exec sed -i '/VISIBLE:/d' {} +
find ./src -type f -name "*.jsx" -exec sed -i '/APP LOADED/d' {} +
find ./src -type f -name "*.jsx" -exec sed -i '/LES COMPOSANTS SONT MORTS OU INVISIBLES/d' {} +

# Étape 2 – Suppression des composants DISABLED partout
echo "🚫 Suppression des imports & JSX des composants désactivés..."
DISABLED_COMPONENTS=$(find src/components -name "*.DISABLED" | sed -E 's|.*/(.*)\.jsx\.DISABLED|\1|' | sort -u)
TARGET_FILES=$(find src -type f \( -name "*.jsx" -o -name "*.tsx" \))

for component in $DISABLED_COMPONENTS; do
  echo "   ❌ Nettoyage de $component..."
  for file in $TARGET_FILES; do
    sed -i "/$component/d" "$file"
    sed -i "/<$component/d" "$file"
  done
done

# Étape 3 – Vérification package.json (si erreurs précédentes)
echo "🛠 Vérification de la validité JSON du package.json..."
cat package.json | jq empty && echo "✅ package.json OK" || {
  echo "❌ ERREUR : package.json invalide. Corrige-le d'abord !"
  exit 1
}

# Étape 4 – Build
echo "⚙️ Build de production avec Vite..."
npm run build || {
  echo "❌ Build échoué. Vérifie les composants restants."
  exit 1
}

# Étape 5 – Déploiement forcé
echo "🚀 Déploiement Vercel PROD..."
vercel --prod --force || {
  echo "❌ Déploiement échoué. Vérifie la config Vercel ou ta connexion."
  exit 1
}

echo "🎯 FINI TONTON : LuxeEvents est propre, buildé, et déployé 🔥"
