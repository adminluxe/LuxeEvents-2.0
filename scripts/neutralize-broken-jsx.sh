#!/bin/bash

echo "🚨 Neutralisation des composants cassés pour compilation temporaire..."

for f in $(cat broken-jsx.log | cut -d: -f1 | sort -u); do
  if [ -f "$f" ]; then
    mv "$f" "${f}.DISABLED"
    echo "❌ $f neutralisé"
  fi
done

echo "✅ Tous les fichiers problématiques ont été désactivés temporairement."
echo "🛠 Tu pourras les réparer un à un sans pression."
