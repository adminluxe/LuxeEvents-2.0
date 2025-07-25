#!/bin/bash

COMPONENTS_DIR="src/components"

if [ ! -d "$COMPONENTS_DIR" ]; then
  echo "❌ Dossier $COMPONENTS_DIR introuvable."
  exit 1
fi

echo "🧠 Débogage global des composants dans $COMPONENTS_DIR"
echo "──────────────────────────────────────────────────────"

for file in "$COMPONENTS_DIR"/*.jsx; do
  echo
  echo "📂 Composant : $file"
  echo "────────────────────────────────────────────"

  echo "👉 Bloc return() détecté :"
  awk '/return\s*\(/,/\);/' "$file"

  echo
  echo "🔍 ClassName suspectes :"
  grep -iE 'className=.*(hidden|opacity-0|h-0|invisible|absolute|z-\[.*\])' "$file" || echo "(aucune classe suspecte)"

  echo
  echo "🔧 Balises principales JSX utilisées :"
  grep -E '<(div|section|main|motion\.div|article)[^>]*>' "$file" || echo "(aucune balise JSX détectée)"

  echo
  echo "✅ Composant inspecté avec succès"
  echo "────────────────────────────────────────────"
done
