#!/usr/bin/env bash
# fix_home_i18n.sh — Activer returnObjects et sécuriser map pour features et services dans Home.jsx
set -euo pipefail

FILE="src/pages/Home.jsx"
if [[ ! -f "$FILE" ]]; then
  echo "❌ Fichier $FILE introuvable ! Vérifiez le chemin."
  exit 1
fi

# 1) Activer returnObjects pour le tableau de features
sed -i "s|const features = t('home.features');|const features = t('home.features', { returnObjects: true });|" "$FILE"

# 2) Sécuriser l'appel à map pour features
sed -i "s|{features\\.map|{Array.isArray(features) ? features.map|g" "$FILE"
sed -i "s|))}|)) : null}|g" "$FILE"

# 3) Déclarer services en tant que tableau avec returnObjects
sed -i "s|const features =.*|&\n  const services = t('home.services', { returnObjects: true });|" "$FILE"

# 4) Sécuriser l'appel à map pour services
sed -i "s|t('home.services', { returnObjects: true })\\.map|Array.isArray(services) ? services.map|g" "$FILE"
# On ajoute : null juste avant la fermeture de la liste
sed -i "s|</li>\\s*</ul>|</li>\n          ) : null}\n        </ul>|g" "$FILE"

echo "✅ Home.jsx mis à jour : returnObjects activé et map sécurisé pour features et services."
