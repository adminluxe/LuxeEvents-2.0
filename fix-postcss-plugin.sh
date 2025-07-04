#!/usr/bin/env bash
set -e

echo "🔧 Installation du plugin PostCSS pour Tailwind…"

# 1) Installer @tailwindcss/postcss
npm install -D @tailwindcss/postcss

# 2) Mettre à jour postcss.config.cjs
cat << 'EOF' > postcss.config.cjs
/** @type {import('postcss-load-config').Config} */
module.exports = {
  plugins: {
    '@tailwindcss/postcss': {},
    autoprefixer: {},
  },
};
EOF

echo "✅ postcss.config.cjs mis à jour"

# 3) Relancer le build
echo "🚀 Lancement du build de production…"
npm run build

echo "🎉 Build terminé sans erreur ! Ton dist/ est prêt à déployer."
