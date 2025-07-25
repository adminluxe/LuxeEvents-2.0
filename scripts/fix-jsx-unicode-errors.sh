#!/bin/bash

echo "🧹 Scan & fix JSX Unicode escape errors in all JSX/TSX files..."

# Extensions à scanner
for file in $(find src/ -type f \( -name "*.jsx" -o -name "*.tsx" \)); do
  if grep -q '\\w-' "$file"; then
    echo "⚠️  Corrige \\w- dans: $file"
    sed -i 's/\\w-/w-/g' "$file"
  fi

  if grep -q '\\h-' "$file"; then
    echo "⚠️  Corrige \\h- dans: $file"
    sed -i 's/\\h-/h-/g' "$file"
  fi

  if grep -q '\\text-' "$file"; then
    echo "⚠️  Corrige \\text- dans: $file"
    sed -i 's/\\text-/text-/g' "$file"
  fi

  if grep -q '\\bg-' "$file"; then
    echo "⚠️  Corrige \\bg- dans: $file"
    sed -i 's/\\bg-/bg-/g' "$file"
  fi
done

echo "✅ Correction terminée. Tu peux maintenant re-push."
