#!/bin/bash

echo "🔍 Analyse de HeroSection.jsx..."

FILE="src/components/HeroSection.jsx"

if [ ! -f "$FILE" ]; then
  echo "❌ Fichier $FILE introuvable"
  exit 1
fi

echo "✅ Fichier trouvé : $FILE"

echo
echo "—— 🎯 Bloc de retour JSX détecté —————————————————————————"
awk '/return\s*\(/,/\);/' "$FILE"

echo
echo "—— 🔍 Classes Tailwind suspectes (hidden, opacity-0, etc.) ———"
grep -iE 'className=.*(hidden|opacity-0|h-0|invisible|absolute|z-\[.*\])' "$FILE"

echo
echo "—— 🧪 Vérification des structures JSX imbriquées ——————————"
grep -E '<(div|section|main|motion\.div)[^>]*>' "$FILE"

echo
echo "🧠 Si aucun bloc JSX n’est affiché ci-dessus, HeroSection est probablement vide ou masqué."
