#!/usr/bin/env bash
set -e

echo "🔧 Correction de l’entrée Vite…"

# 1) Choisis le bon index.html
if [ -f public/index.html ]; then
  TARGET="public/index.html"
elif [ -f index.html ]; then
  TARGET="index.html"
else
  echo "❌ Aucun index.html trouvé ! (public/index.html ou index.html)" >&2
  exit 1
fi
echo "→ Patch de $TARGET"

# 2) Forcer le script d’entrée vers /src/main.jsx
#    on cherche la balise <script type="module" src="...">
#    et on la remplace
sed -i "s|<script type=\"module\" src=\"[^\"]*\">|<script type=\"module\" src=\"/src/main.jsx\">|g" "$TARGET"
echo "✔ $TARGET corrigé pour charger /src/main.jsx"

# 3) Désactiver toute registration SW dans workbox-config.cjs et generate-sw.js
for SW in workbox-config.cjs generate-sw.js; do
  if [ -f "$SW" ]; then
    sed -i "s|navigator\.serviceWorker\.register|/* SW registration disabled */undefined|g" "$SW"
    echo "✔ SW désactivé dans $SW"
  fi
done

# 4) Nettoyer le cache Vite
rm -rf node_modules/.vite
echo "✔ Cache Vite supprimé"

# 5) Injecter un Landing de test « hotpink »
cat > src/pages/Landing.jsx << 'LANDING'
import React from 'react';

export default function Landing() {
  return (
    <h1 style={{ color: 'hotpink', textAlign: 'center', marginTop: '4rem' }}>
      🍾 Tonton brille ici ! 🍾
    </h1>
  );
}
LANDING

echo "✔ Test hotpink injecté dans src/pages/Landing.jsx"
echo
echo "✅ Tout est prêt ! Lance maintenant :"
echo "   npm run dev -- --host"
