#!/usr/bin/env bash
set -e

# 1) Forcer le bon <script> dans index.html (racine) ou public/index.html
for html in index.html public/index.html; do
  if [ -f "$html" ]; then
    echo "🔧 Ajustement du point d’entrée dans $html"
    sed -i 's|<script type="module" src=".*"></script>|<script type="module" src="/src/main.jsx"></script>|' "$html"
  fi
done

# 2) Désactiver temporairement le service worker
for f in workbox-config.cjs generate-sw.js; do
  if [ -f "$f" ]; then
    echo "🚫 Commenter la registration du SW dans $f"
    sed -i 's|^\(.*registerServiceWorker.*\)$|// \1|' "$f"
  fi
done

# 3) Remplacer Landing par un composant ultra-visible
echo "🎨 Injection du test hotpink dans src/pages/Landing.jsx"
cat > src/pages/Landing.jsx << 'EOF'
import React from 'react';
export default function Landing() {
  return (
    <div style={{ padding: '4rem', textAlign: 'center' }}>
      <h1 style={{ color: 'hotpink', fontSize: '4rem' }}>
        🍾 Tonton brille ici ! 🍾
      </h1>
      <p>Si vous voyez ce message, la landing est bien chargée.</p>
    </div>
  );
}
EOF

# 4) Clear le cache vite
echo "⚙️ Suppression de node_modules/.vite"
rm -rf node_modules/.vite

echo "✅ Debug scaffolding appliqué. Maintenant : npm run dev -- --host"
