#!/usr/bin/env bash
set -euo pipefail

echo "🍹 Démarrage du Perf Cocktail à la Tonton…"

# 1) Libs légères
echo "1) Installation de lodash-es et dayjs…"
npm install lodash-es dayjs --save

# 2) Imports ciblés
echo "2) Patch imports lodash → lodash-es…"
find src -type f \( -name "*.js" -o -name "*.jsx" \) -exec sed -i -E \
  -e "s#import _ from 'lodash';#// import lodash générique supprimé#g" \
  -e "s#import ([^ ]+) from 'lodash/([^']+)';#import \1 from 'lodash-es/\2';#g" \
  {} +

# 3) Pré-connexion
echo "3) Pré-connexion vers tes APIs…"
sed -i '/<head>/a \
  <link rel="preconnect" href="https://api.ton-strapi.io" crossorigin>\
  <link rel="preconnect" href="https://cdn.ton-cms.com" crossorigin>' index.html

# 4) Images next-gen
echo "4) Installation et conversion WebP & AVIF…"
npm install --save-dev imagemin-cli imagemin-webp imagemin-avif >/dev/null
mkdir -p public/images
# convertit les .png, .jpg, .jpeg du dossier assets s'ils existent
if [ -d "src/assets/images" ]; then
  find src/assets/images -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | while read img; do
    npx imagemin-cli "$img" --plugin=webp --out-dir=public/images >/dev/null || true
    npx imagemin-cli "$img" --plugin=avif --out-dir=public/images >/dev/null || true
  done
fi

echo "   → WebP/AVIF générés dans public/images (si des sources existent)"

# 5) Lazy-loading natif
echo "5) Ajout de loading=\"lazy\" sur toutes les images…"
find src -type f \( -name "*.html" -o -name "*.js" -o -name "*.jsx" \) | while read file; do
  sed -i -E 's#<img((?!loading=")[^>]*)(>)#<img loading="lazy"\1\2#g' "$file" || true
done

# 6) Pré-chargement du chunk critique
echo "6) Précharge modulepreload pour Gallery.jsx…"
sed -i '/<head>/a \
  <link rel="modulepreload" href="/src/components/Gallery.jsx" />' index.html || true

# 7) Rappel pour le code-splitting
echo "7) 💡 Pense à mettre les routes lourdes en React.lazy() pour un vrai code-splitting."

echo "✅ Perf Cocktail terminé !"
echo -e "→ Lance ton build :\n    npm run build && npm run preview"
