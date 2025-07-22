#!/bin/bash

echo "📦 Patch logo192.png manquant..."

# Vérifie si on a le fichier dans assets/logo
if [ -f public/assets/lang/logo192.png ]; then
  cp public/assets/lang/logo192.png public/logo192.png
  echo "✅ Copie depuis assets/lang/"
elif [ -f logo192.png ]; then
  cp logo192.png public/logo192.png
  echo "✅ Copie depuis racine projet"
else
  echo "❌ Fichier logo192.png introuvable. Ajoute-le manuellement dans public/"
fi

echo "♻️ Déploiement en cours..."
vercel --prod
