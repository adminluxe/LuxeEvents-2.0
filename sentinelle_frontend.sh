#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "🌒 Sentinelle en veille. Diagnostic et purification en cours…"

# 1. Vérification des imports foireux
echo "🧪 Étape 1 : Scan des imports suspects (react-refresh)"
if grep -R "react-refresh/runtime" src/; then
  echo "⚠️ Import suspect détecté. Suppression en cours…"
  grep -RIl "react-refresh/runtime" src/ | while read -r file; do
    sed -i.bak '/react-refresh\/runtime/d' "$file"
    sed -i '/runtime\.js/d' "$file"
    echo "   ✔ Nettoyé : $file"
  done
else
  echo "✅ Aucun import react-refresh détecté"
fi

# 2. Symlink de secours
if grep -R "react-refresh/runtime" -q src/; then
  echo "🔗 Symlink fallback vers react-refresh"
  rm -rf src/react-refresh
  ln -s ../node_modules/react-refresh src/react-refresh
fi

# 3. Port 3000
echo "🔍 Vérification du port 3000"
if lsof -i :3000 &>/dev/null; then
  echo "🔪 Port utilisé : on kill tout !"
  lsof -t -i :3000 | xargs kill -9
else
  echo "✅ Port 3000 libre"
fi

# 4. Nettoyage de l’environnement
echo "🗑️ Suppression de node_modules et lockfiles"
rm -rf node_modules package-lock.json yarn.lock

# 5. Réinstallation
echo "📦 Réinstallation des dépendances…"
npm install

# 6. Lancement
echo "🚀 Lancement du projet en mode dev"
npm start
