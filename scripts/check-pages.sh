#!/bin/bash

echo "🔍 Vérification des fichiers essentiels..."

MISSING=0

FILES=(
  "src/components/Navbar.jsx"
  "src/components/Footer.jsx"
  "src/components/CookieBanner.jsx"
  "src/pages/HomePage.jsx"
  "src/pages/RequestQuotePage.jsx"
  "src/pages/MediaPage.jsx"
  "src/pages/ServicesPage.jsx"
  "src/i18n.js"
)

for FILE in "${FILES[@]}"; do
  if [ ! -f "$FILE" ]; then
    echo "❌ Manquant : $FILE"
    MISSING=1
  else
    echo "✅ Présent : $FILE"
  fi
done

if [ "$MISSING" -eq 1 ]; then
  echo "⛔ Des fichiers sont manquants. Corrige avant de lancer le build."
  exit 1
else
  echo "🎉 Tous les fichiers critiques sont en place !"
fi
