#!/usr/bin/env bash
set -e

echo "🔧 Fix PostCSS config pour ESM…"

# 1) Supprime l'ancien fichier JS
rm -f postcss.config.js
echo "🗑️  Ancien postcss.config.js supprimé"

# 2) Crée le nouveau CommonJS
cat << 'EOF' > postcss.config.cjs
/** @type {import('postcss-load-config').Config} */
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
};
EOF
echo "✅  postcss.config.cjs créé"

# 3) Lance le build
echo "🚀  Lancement du build de production…"
npm run build

echo "🎉  Build terminé ! Vérifie dist/ pour ton site prêt à déployer."
