#!/bin/bash

echo "📋 Scan des fichiers .jsx et .tsx contenant des erreurs JSX connues..."

grep -Ern --include=\*.{jsx,tsx} \
  -e '<[^/>]*$' \
  -e 'Unexpected token' \
  -e 'Unterminated JSX contents' \
  -e 'Adjacent JSX elements' \
  -e 'Unexpected token <' \
  src/ components/ > broken-jsx.log || echo "✅ Aucun fichier suspect trouvé."

echo "🧾 Résultats stockés dans broken-jsx.log"
