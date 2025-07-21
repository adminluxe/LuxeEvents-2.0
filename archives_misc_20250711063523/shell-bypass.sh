#!/usr/bin/env bash
set -e

# 1) Renommer les configs en .cjs pour PostCSS et Tailwind
[ -f postcss.config.js ]   && mv postcss.config.js   postcss.config.cjs
[ -f tailwind.config.js ]  && mv tailwind.config.js  tailwind.config.cjs

# 2) Mettre à jour les scripts dans package.json
pnpm pkg set \
  scripts.build:css="pnpm exec tailwindcss -i src/index.css -o src/prebuilt-tailwind.css --minify" \
  scripts.build="pnpm run build:css && vite build"

# 3) Installer (ou réinstaller) Tailwind v4 + PostCSS + Autoprefixer
pnpm add -D tailwindcss@4.1.11 postcss@8 autoprefixer@10

# 4) Relancer l’installation et vérifier la génération CSS
pnpm install
pnpm run build:css && ls -l src/prebuilt-tailwind.css

echo "✅ Tout est prêt : lancez désormais 'pnpm run build' pour compiler l'app." 
