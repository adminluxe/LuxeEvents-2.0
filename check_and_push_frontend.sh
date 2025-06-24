#!/usr/bin/env bash
set -euo pipefail

declare -a FILES=(
  "package.json"
  "tailwind.config.js"
  "deploy-frontend.sh"
  "check_and_push_frontend.sh"
  "index.html"
  "src/main.jsx"
)

MISSING=()
for f in "${FILES[@]}"; do
  [ ! -e "$f" ] && MISSING+=("$f")
done

if [ ${#MISSING[@]} -gt 0 ]; then
  echo "❌ Fichiers manquants :"
  for m in "${MISSING[@]}"; do
    echo "   • $m"
  done
  exit 1
fi

echo "✅ Tous les fichiers sont présents."
git add "${FILES[@]}"
git commit -m "chore: verification frontend before push"
git push
echo "🚀 Push frontend OK !"
