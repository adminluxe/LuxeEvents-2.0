#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'fix-imports'. Description à compléter.

echo "🚀 [START] Nettoyage des imports .js et suppression des imports interdits"

# 1. Supprimer les imports vers react-refresh/runtime.js dans tout le src/
find ./src -type f -name "*.js" -exec sed -i '/react-refresh\/runtime/d' {} \;

# 2. Ajouter l’extension `.js` manquante dans les imports relatifs (type: module oblige)
find ./src -type f -name "*.js" | while read file; do
  sed -i -E 's|(import .* from ["'"'"']\.\/[^"'"'"']*)(["'"'"'])|\1.js\2|g' "$file"
done

# 3. Log des fichiers modifiés
echo "✅ Imports corrigés et react-refresh supprimé."
echo "📁 Fichiers concernés :"
grep -rl 'import ' ./src | grep '\.js$'

echo "🎯 [DONE] Prêt à redémarrer ton app comme un seigneur : npm start"
