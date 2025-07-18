#!/bin/bash
echo "📦 Lancement du traitement des médias LuxeEvents..."

# Répertoires sources locaux
SRC1="/home/tontoncestcarre/uploads/medias_final"
SRC2="/home/tontoncestcarre/uploads/medias_final_new"

# Répertoires cibles
IMG_DIR="public/media/images"
VID_DIR="public/media/videos"
mkdir -p "$IMG_DIR" "$VID_DIR"

# Formats cibles
TARGET_IMG_EXT=".webp"
TARGET_VIDEO_EXT=".mp4"
TARGET_RES="1920x1080"

# Dépendances requises : ffmpeg, imagemagick
command -v ffmpeg >/dev/null 2>&1 || { echo >&2 "❌ ffmpeg requis."; exit 1; }
command -v convert >/dev/null 2>&1 || { echo >&2 "❌ imagemagick requis (convert)."; exit 1; }

img_count=1
video_count=1
skipped=()

echo "🔍 Analyse des fichiers dans $SRC1 et $SRC2..."

process_file() {
  local path="$1"
  local ext="${path##*.}"
  local filename=""

  if [[ "$ext" =~ ^(jpg|jpeg|png|bmp|tiff|gif|webp)$ ]]; then
    filename="photo-$(printf "%03d" $img_count).webp"
    convert "$path" -resize $TARGET_RES -quality 90 "$IMG_DIR/$filename" 2>/dev/null
    if [[ $? -eq 0 ]]; then
      echo "🖼️ Image convertie : $filename"
      ((img_count++))
    else
      echo "⚠️ Échec image : $path"
      skipped+=("$path")
    fi

  elif [[ "$ext" =~ ^(mp4|mov|avi|mkv|webm|m4v)$ ]]; then
    filename="video-$(printf "%03d" $video_count).mp4"
    ffmpeg -y -i "$path" -vf "scale=$TARGET_RES" -c:v libx264 -preset fast -crf 23 -c:a aac -strict -2 "$VID_DIR/$filename" < /dev/null &>/dev/null
    if [[ $? -eq 0 ]]; then
      echo "🎞️ Vidéo convertie : $filename"
      ((video_count++))
    else
      echo "⚠️ Échec vidéo : $path"
      skipped+=("$path")
    fi

  else
    skipped+=("$path")
  fi
}

export -f process_file
find "$SRC1" "$SRC2" -type f | while read -r file; do process_file "$file"; done

echo "✅ Médias traités : $((img_count-1)) images, $((video_count-1)) vidéos"
if [ ${#skipped[@]} -gt 0 ]; then
  echo "⚠️ ${#skipped[@]} fichiers ignorés (non convertibles)"
fi

# Git commit automatique
git add public/media
git commit -m "📸🎞️ Traitement & optimisation des médias LuxeEvents (images/vidéos)"

echo "🎯 Commit terminé. Les fichiers sont prêts à être push."
