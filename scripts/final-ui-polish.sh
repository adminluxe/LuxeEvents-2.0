#!/bin/bash

echo "✨ Nettoyage final des artefacts visuels (traits noirs, hr, borders inutiles)..."

TARGETS=(
  src/components/HeroSection.jsx
  src/components/ServicesSection.jsx
  src/components/QuoteForm.jsx
  src/components/Footer.jsx
)

for FILE in "${TARGETS[@]}"; do
  if [ -f "$FILE" ]; then
    echo "🔧 Nettoyage de $FILE"

    # Supprimer les balises <hr /> ou <hr>
    sed -i '/<hr\s*\/>/d' "$FILE"
    sed -i '/<hr>/d' "$FILE"

    # Supprimer les classes tailwind border noires
    sed -i 's/\bborder-b\b//g' "$FILE"
    sed -i 's/\bborder-t\b//g' "$FILE"
    sed -i 's/\bborder-black\b//g' "$FILE"
    sed -i 's/\bborder-neutral-800\b//g' "$FILE"

    # Supprimer les balises seules avec "border" en div
    sed -i '/<div[^>]*className=["'"'"'][^"'"'"']*border[^"'"'"']*["'"'"'].*\/>/d' "$FILE"
  fi
done

echo "✅ Nettoyage terminé."

echo "🧪 Rebuild final pour vérification..."
npm run build && vercel --prod --force

echo "🎉 LuxeEvents est propre, sans trait parasite."
