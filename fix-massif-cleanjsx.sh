#!/bin/bash
echo "🧹 Nettoyage des blocs VISIBLE mal placés..."

find src/components -type f -name "*.jsx" | while read file; do
  # Vérifie si une ligne commence par ' <div className=' sans balisage JSX (souvent ligne seule)
  if grep -q '^ *<div className="bg-green-200.*VISIBLE:' "$file"; then
    echo "🔧 Correction dans : $file"
    tmpfile=$(mktemp)
    echo "import React from 'react';" > "$tmpfile"
    echo "" >> "$tmpfile"
    echo "export default function $(basename "$file" .jsx)() {" >> "$tmpfile"
    echo "  return (" >> "$tmpfile"
    echo "    <>" >> "$tmpfile"
    sed -n '/<div className="bg-green-200/,/<\/div>/p' "$file" >> "$tmpfile"
    sed -e '1,/return/d' "$file" >> "$tmpfile" | sed 's/^/    /' >> "$tmpfile"
    echo "    </>" >> "$tmpfile"
    echo "  );" >> "$tmpfile"
    echo "}" >> "$tmpfile"
    mv "$tmpfile" "$file"
  fi
done

echo "✅ Correction massive terminée. Relance avec 'npm run build'"
