#!/bin/bash

CSS_FILE=$(find src -name "*.css" | head -n1)

if [ ! -f "$CSS_FILE" ]; then
  echo "❌ Aucun fichier CSS trouvé dans src/"
  exit 1
fi

echo "🎯 Fichier détecté : $CSS_FILE"

if grep -q ".text-gold" "$CSS_FILE"; then
  echo "✅ Les classes or sont déjà présentes."
  exit 0
fi

echo "✨ Injection des classes Luxe (.text-gold, .bg-gold, .border-gold, .hover\\:text-gold)..."

sed -i "/^@tailwind utilities;/a\
\n/* === LuxeEvents Custom Classes === */\
.text-gold {\n  color: #f8e9c8;\n}\
\n.bg-gold {\n  background-color: #f8e9c8;\n}\
\n.border-gold {\n  border-color: #f8e9c8;\n}\
\n.hover\\:text-gold:hover {\n  color: #f8e9c8;\n}" "$CSS_FILE"

echo "✅ Classes Luxe injectées avec succès dans $CSS_FILE"
