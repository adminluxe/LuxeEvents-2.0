#!/bin/bash

echo "🔧 Correction des console.log mal placés dans les composants..."

for file in src/components/*.jsx; do
  # Déplace toute ligne "console.log" présente juste après "return (" vers juste avant
  sed -i '/return *(/{N;/console\.log/s/return *(\n *console\.log/\0\nreturn (/;}' "$file"

  # Puis si encore des cas bruts, on déplace ligne par ligne
  sed -i '/return *(/{n;/console\.log/ { h; d; }; }' "$file"
  sed -i '/return *(/{g;}' "$file"

  echo "✅ Corrigé : $(basename $file)"
done

echo "🚀 Rebuild prêt. Relance avec 'npm run dev' ou redeploie pour test final."
