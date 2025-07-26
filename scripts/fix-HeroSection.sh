#!/bin/bash

FILE="src/components/HeroSection.jsx"

echo "🛠️ Fix HeroSection – Fermeture correcte des fragments JSX"

# Supprime tout </> orphelin
sed -i 's|</>||g' "$FILE"

# Injecte un fragment ouvrant si absent
if ! grep -q "<>" "$FILE"; then
  sed -i '/return (/a \    <>' "$FILE"
fi

# Injecte le fragment fermant juste avant );
sed -i '/);/i \    </>' "$FILE"

echo "🔁 Rebuild propre après fix..."
npm run build && vercel --prod --force --yes
