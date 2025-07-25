#!/bin/bash

echo "🧼 Purge stricte des échappements \ dans les className JSX..."

find src/ -type f \( -name "*.jsx" -o -name "*.tsx" \) | while read file; do
  echo "🔍 Analyse : \$file"
  sed -i \
    -e 's/\\w-/w-/g' \
    -e 's/\\h-/h-/g' \
    -e 's/\\text-/text-/g' \
    -e 's/\\bg-/bg-/g' \
    -e 's/\\p-/p-/g' \
    -e 's/\\m-/m-/g' \
    -e 's/\\z-/z-/g' \
    "$file"
done

echo "✅ Nettoyage terminé. Tu peux re-push."
