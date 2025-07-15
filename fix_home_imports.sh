#!/usr/bin/env bash
set -euo pipefail
FILE="src/pages/Home.jsx"

# 1) Inject import eventsData & Map
grep -q "import { eventsData }" "$FILE" || \
  sed -i "1s|import Layout.*|&\nimport { eventsData } from '@/data/events'\nimport Map from '@/components/Map'|" "$FILE"

# 2) Replace (ou ajoute) la section Map juste après Services
#    (on supprime d'abord tout bloc <Map …> existant pour éviter les doublons)
sed -i "/<Map events=/,/<\/section>/d" "$FILE"
sed -i "/<\/section>/a \
\
      <section className=\"my-16\">\
        <h2 className=\"text-2xl font-bold mb-4\">{t('home.mapTitle')}</h2>\
        <Map events={eventsData} />\
      </section>" "$FILE"

echo "✅ Home.jsx mis à jour avec import eventsData & Map. Relance le dev : pnpm run dev"
