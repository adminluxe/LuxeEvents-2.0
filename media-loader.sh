#!/bin/bash

echo "🖼️ Génération du fichier gallery.json pour le carrousel..."

TARGET_DIR="public/media"
OUTPUT_FILE="src/data/gallery.json"
mkdir -p "$(dirname $OUTPUT_FILE)"

echo "[" > "$OUTPUT_FILE"

i=1
find "$TARGET_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.mp4" \) | sort | while read -r file; do
  filename=$(basename "$file")
  ext="${filename##*.}"

  if [[ "$ext" == "mp4" ]]; then
    echo "  { \"type\": \"video\", \"src\": \"/media/$filename\" }," >> "$OUTPUT_FILE"
  else
    echo "  { \"type\": \"image\", \"src\": \"/media/$filename\" }," >> "$OUTPUT_FILE"
  fi

  ((i++))
done

# Supprimer la dernière virgule
truncate -s-2 "$OUTPUT_FILE"
echo -e "
]" >> "$OUTPUT_FILE"

echo "✅ Fichier $OUTPUT_FILE généré."
