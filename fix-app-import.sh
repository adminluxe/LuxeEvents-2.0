#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'fix-app-import'. Description à compléter.

echo "🔧 Correction spécifique de index.js"

# 1. Corriger .js.js vers .js dans index.js
sed -i 's|\.js\.js|.js|g' ./src/index.js

# 2. Supprimer tout import de react-refresh/runtime.js dans le projet
find ./src -type f -name "*.js" -exec sed -i '/react-refresh\/runtime/d' {} \;

# 3. Affichage final
echo "✅ Corrections appliquées :"
grep -H 'import ' ./src/index.js

echo "🎬 Tu peux relancer ton app avec : npm start"
