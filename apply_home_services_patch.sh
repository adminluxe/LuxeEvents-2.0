#!/usr/bin/env bash
# apply_home_services_patch.sh — Ajout de services + sécurisation map dans Home.jsx
set -euo pipefail

FILE="src/pages/Home.jsx"
if [[ ! -f "$FILE" ]]; then
  echo "❌ $FILE introuvable !"
  exit 1
fi

# 1) Ajouter déclaration services après features
sed -i "/const features = t('home.features'/a \
  const services = t('home.services', { returnObjects: true });" "$FILE"

# 2) Sécuriser map pour services
sed -i "s|{t('home.services', { returnObjects: true })\\.map|{Array.isArray(services) ? services.map|g" "$FILE"
sed -i "s|))}|)) : null}|g" "$FILE"

echo "✅ Home.jsx mis à jour : services ajouté et map sécurisé."
