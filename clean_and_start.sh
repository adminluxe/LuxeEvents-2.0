#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "🧹 1. Suppression des imports React Refresh dans src/"

# Pour chaque JS dans src, on supprime les lignes qui mentionnent react-refresh/runtime
find src -type f -name '*.js' | while read -r file; do
  if grep -q "react-refresh/runtime" "$file"; then
    sed -i.bak '/react-refresh\/runtime/d' "$file"
    echo "   ✔ Nettoyé $file"
  fi
done

echo "🔭 2. Vérification de la présence d'appels à runtime dans src/"
# (on supprime aussi tout require(...) si présent)
find src -type f -name '*.js' | while read -r file; do
  if grep -q "reactRefreshRuntime" "$file"; then
    sed -i.bak '/reactRefreshRuntime/d' "$file"
    echo "   ✔ Retiré appel runtime dans $file"
  fi
done

echo "🔍 3. Tuer processus sur le port 3000 (le cas échéant)"
# Si quelque chose écoute sur 3000, on le tue
if lsof -i :3000 &>/dev/null; then
  PIDS=$(lsof -t -i :3000)
  echo "   → kill PIDs: $PIDS"
  echo "$PIDS" | xargs kill -9
else
  echo "   → port 3000 libre"
fi

echo "🗑️ 4. Nettoyage node_modules & lockfile"
rm -rf node_modules package-lock.json

echo "📥 5. Réinstallation des dépendances"
npm install

echo "🚀 6. Lancement du serveur de dev"
npm start
