#!/bin/bash
if [ -z "$1" ]; then
  echo "❌ Merci d’ajouter un message de commit."
  echo "👉 Exemple : ./push.sh \"✨ Ajout animation Hero\""
  exit 1
fi

echo "📤 Push en cours avec message : $1"
git add .
git commit -m "$1"
git push origin dev
