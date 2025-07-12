#!/usr/bin/env bash
set -euo pipefail

echo "🚀 1. Installer Tailwind/PostCSS en local"
pnpm add -D tailwindcss postcss autoprefixer

echo "🛠 2. Initialiser tailwind.config.js + postcss.config.js (si besoin)"
[ -f tailwind.config.js ] || npx tailwindcss init
cat > postcss.config.js << 'CFG'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
CFG

echo "✏️ 3. S’assurer que src/index.css contient bien les directives Tailwind"
grep -q "@tailwind base" src/index.css || cat << 'EOF' > src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Ajoutez ici vos CSS sur-mesure */
EOF

echo "🗑 4. Supprimer l’include CDN de index.html"
sed -i -E '/cdn.tailwindcss.com/d' index.html

echo "🎨 5. Générer le CSS prod optimisé"
npx tailwindcss -i ./src/index.css -o ./public/tailwind.css --minify

echo "✂️ 6. Nettoyer caches Vite & anciens builds"
rm -rf node_modules/.vite dist .cache

echo "🔧 7. Installer deps & builder"
pnpm install
pnpm run build

echo "📦 8. Démarrer un serveur de preview"
npx serve -s dist

echo "✅ Tout est prêt ! Ouvrez http://localhost:3000 (ou le port indiqué) pour vérifier."  
