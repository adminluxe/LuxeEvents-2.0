#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'mega_clean_start'. Description à compléter.
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "🧹 1) Suppression hardcore des imports 'react-refresh/runtime'…"
# Supprime toutes les lignes contenant react-refresh/runtime ou runtime.js
grep -RIl "react-refresh/runtime" src/ | while read -r file; do
  sed -i.bak '/react-refresh\/runtime/d' "$file"
  sed -i '/runtime\.js/d' "$file"
  echo "   ✔ Purgé dans $file"
done

echo "🧪 2) Vérification : si des imports subsistent, on crée un symlink hack…"
# Si on trouve encore un import runtime, on symlink node_modules/react-refresh → src/react-refresh
if grep -R "react-refresh/runtime" -q src/; then
  echo "   ⚠ Import introuvable, création d'un lien symbolique src/react-refresh → node_modules/react-refresh"
  rm -rf src/react-refresh
  ln -s ../node_modules/react-refresh src/react-refresh
fi

echo "🔍 3) Kill tout processus écoutant sur le port 3000…"
if lsof -i :3000 &>/dev/null; then
  echo "   → Processus détecté, on kill…"
  lsof -t -i :3000 | xargs kill -9
else
  echo "   → Port 3000 libre."
fi

echo "🗑️ 4) Supprimer node_modules & lockfile…"
rm -rf node_modules package-lock.json yarn.lock

echo "📥 5) Réinstaller les dépendances…"
npm install

echo "🚀 6) Lancer la dev : npm start"
npm start
