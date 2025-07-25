#!/bin/bash

echo "🔧 Patch global anti-invisibilité en cours..."

for file in src/components/*.jsx; do
  component=$(basename "$file" .jsx)

  # Injection console.log dans useEffect ou en début de return
  if grep -q 'return\s*(' "$file"; then
    sed -i "/return\s*(/a\ \ \ \ console.log('🟢 MONTÉ: $component');" "$file"
  fi

  # Ajout de style={{ opacity: 1 }} à motion.div, motion.section
  sed -i 's/<motion.\(div\|section\)/<motion.\1 style={{ opacity: 1 }}/g' "$file"

  # Optionnel : désactiver FadeUpWrapper en le remplaçant par <div>
  sed -i 's/<FadeUpWrapper>/<div>/g' "$file"
  sed -i 's/<\/FadeUpWrapper>/<\/div>/g' "$file"

  echo "✅ Patch appliqué à $component"
done

echo "🚀 Relance avec 'npm run dev' ou redeploie pour test complet"
