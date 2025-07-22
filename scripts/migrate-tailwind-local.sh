#!/bin/bash

echo "🔧 Migration Tailwind CDN ➜ local (PostCSS plugin)"

pnpm add -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

echo "✅ tailwind.config.js et postcss.config.js créés"

echo "⚙️ Remplacement du <script src=...> par @tailwind imports"

# On nettoie le HTML (si encore présent, dans public/index.html ou autre)
find . -type f -name "*.html" -exec sed -i '' '/cdn\.tailwindcss\.com/d' {} +

echo "🧵 Ajoute à ton fichier globals.css :"

echo '@tailwind base;'
echo '@tailwind components;'
echo '@tailwind utilities;'

echo "🎯 Ajouté à ./src/styles/globals.css (si utilisé)."

