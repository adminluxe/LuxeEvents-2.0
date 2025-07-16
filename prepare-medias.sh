#!/bin/bash

echo "🎞️ Préparation des médias LuxeEvents en cours..."

SOURCE_DIRS=(
  "/home/tontoncestcarre/uploads/medias_final"
  "/home/tontoncestcarre/uploads/medias_final_new"
)
TARGET_DIR="public/media"
mkdir -p "$TARGET_DIR"

i=1

for dir in "${SOURCE_DIRS[@]}"; do
  find "$dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.mp4" -o -iname "*.mov" \) | while read -r file; do
    ext="${file##*.}"
    base="media-${i}.$ext"
    dest="$TARGET_DIR/$base"

    # Copie et compression d’image (16:9 via imagemagick)
    if [[ "$ext" =~ ^(jpg|jpeg|png|webp)$ ]]; then
      convert "$file" -resize 1280x720^ -gravity center -extent 1280x720 -strip -quality 85 "$dest"
    elif [[ "$ext" =~ ^(mp4|mov)$ ]]; then
      # Conversion en .mp4 standard compressé et renommage
      newfile="$TARGET_DIR/media-${i}.mp4"
      ffmpeg -i "$file" -c:v libx264 -preset fast -crf 28 -c:a aac -b:a 128k "$newfile"
    fi

    ((i++))
  done
done

echo "✅ Médias renommés, optimisés et déplacés dans $TARGET_DIR"
