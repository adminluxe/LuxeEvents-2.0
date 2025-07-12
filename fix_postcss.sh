#!/usr/bin/env bash
set -euo pipefail

echo "🔄 Renommage postcss.config.js → postcss.config.cjs"
if [ -f postcss.config.js ]; then
  mv postcss.config.js postcss.config.cjs
else
  echo "⚠️  Aucun postcss.config.js trouvé, j’abandonne."
  exit 1
fi

echo "✅ postcss.config.cjs créé :"
sed -n '1,20p' postcss.config.cjs

echo "✂ Nettoyage caches Vite & anciens builds…"
rm -rf node_modules/.vite dist .cache

echo "📦 Réinstall et build…"
pnpm install
pnpm run build

echo "🎉 Build terminé !"
