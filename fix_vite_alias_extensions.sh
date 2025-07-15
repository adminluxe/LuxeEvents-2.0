#!/usr/bin/env bash
set -euo pipefail

CFG="vite.config.js"
echo "🔧 Ajout des extensions JSX dans la config Vite…"

# Insère la ligne extensions juste après `alias: { … },`
sed -i "/alias: {/,/},/s|alias: {|alias: {\n      extensions: ['.js','.jsx','.ts','.tsx','.json'],|" $CFG

echo "✅ Extensions ajoutées dans $CFG."
echo "   Relancez votre dev : pnpm run dev"
