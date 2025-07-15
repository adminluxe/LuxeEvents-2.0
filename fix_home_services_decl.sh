#!/usr/bin/env bash
# Supprime les doublons et (re)déclare correctement `services` dans Home.jsx

set -euo pipefail

FILE="src/pages/Home.jsx"
if [[ ! -f "$FILE" ]]; then
  echo "❌ $FILE introuvable !"
  exit 1
fi

echo "🔧 Suppression des anciennes déclarations de services…"
# on supprime TOUTES les lignes commençant par const services
sed -i "/^.*const services =/d" "$FILE"

echo "🔧 Insertion de la déclaration services après features…"
# on ajoute juste après la ligne features
sed -i "/const features = t('home.features'/a \
  const services = t('home.services', { returnObjects: true });" "$FILE"

echo "✅ Home.jsx nettoyé des doublons et services correctement déclaré !"
