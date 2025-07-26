#!/bin/bash

echo "🧠 Scan global : suppression des composants DISABLED dans tous les fichiers .jsx/.tsx..."

DISABLED_COMPONENTS=$(find src/components -name "*.DISABLED" | sed -E 's|.*/(.*)\.jsx\.DISABLED|\1|' | sort -u)
TARGET_FILES=$(find src -type f \( -name "*.jsx" -o -name "*.tsx" \))

for component in $DISABLED_COMPONENTS; do
  echo "❌ Suppression de $component dans tous les fichiers..."

  for file in $TARGET_FILES; do
    sed -i "/$component/d" "$file"
    sed -i "/<$component/d" "$file"
  done
done

echo "✅ Tous les composants DISABLED ont été nettoyés des fichiers sources."
