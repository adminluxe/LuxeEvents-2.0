#!/bin/bash

echo "👻 Suppression des éléments fantômes restants (traits noirs, hr, border...)"

FILES=(
  src/components/HeroSection.jsx
  src/components/QuoteForm.jsx
  src/components/Footer.jsx
  src/components/ServicesSection.jsx
  src/components/SwipeStory.jsx
  src/App.jsx
)

for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "🔍 Nettoyage de $file"

    # Supprimer les balises <hr /> et <hr>
    sed -i '/<hr\s*\/>/d' "$file"
    sed -i '/<hr>/d' "$file"

    # Supprimer toutes les classes tailwind de border noire
    sed -i 's/\bborder-t\b//g' "$file"
    sed -i 's/\bborder-b\b//g' "$file"
    sed -i 's/\bborder-black\b//g' "$file"
    sed -i 's/\bborder-neutral-800\b//g' "$file"
    sed -i 's/\bborder\b//g' "$file"

    # Supprimer les <div ... className="...border..."/> directement fermés
    sed -i '/<div[^>]*className=["'"'"'][^"'"'"']*border[^"'"'"']*["'"'"'].*\/>/d' "$file"
  fi
done

echo "🧼 Nettoyage terminé. Rebuild + Déploiement..."

npm run build && vercel --prod --force

echo "✅ Casper exorcisé. LuxeEvents est prêt pour le monde."
