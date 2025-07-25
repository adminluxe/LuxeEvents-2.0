#!/bin/bash

echo "🛠 Injection d’un fallback de visibilité dans tous les composants…"

for file in src/components/*.jsx; do
  if grep -q 'return\s*(' "$file"; then
    sed -i '/return\s*(/a\ \ \ \ <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: '"$(basename $file)"'</div>' "$file"
    echo "✅ Fallback injecté dans $(basename "$file")"
  fi
done

echo "🚀 Relance ton projet avec 'npm run dev' ou redeploie pour test visuel"
