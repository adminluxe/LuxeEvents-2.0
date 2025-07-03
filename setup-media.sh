#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="/home/tontoncestcarre/uploads/medias_final"
DST_DIR="public/media"

echo "🎬 Récupération des médias depuis $SRC_DIR…"

# 1) Crée le dossier public/media et copie tout
mkdir -p $DST_DIR
cp "$SRC_DIR"/*.{mp4,webm,jpg,jpeg,png} $DST_DIR 2>/dev/null || true

# 2) Choix automatique du hero-loop.mp4 (première vidéo trouvée)
VIDEO_FILE=$(find $DST_DIR -type f \( -name '*.mp4' -o -name '*.webm' \) | head -n1)
if [[ -n "$VIDEO_FILE" ]]; then
  cp "$VIDEO_FILE" public/hero-loop.mp4
  echo " • Vidéo héro : $(basename "$VIDEO_FILE") copiée en public/hero-loop.mp4"
else
  echo " ⚠️ Aucune vidéo trouvée dans $DST_DIR"
fi

# 3) Choix automatique du hero.jpg (première image trouvée)
IMG_FILE=$(find $DST_DIR -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | head -n1)
if [[ -n "$IMG_FILE" ]]; then
  cp "$IMG_FILE" public/hero.jpg
  echo " • Image héro : $(basename "$IMG_FILE") copiée en public/hero.jpg"
else
  echo " ⚠️ Aucune image trouvée dans $DST_DIR"
fi

echo "✅ Media Hook terminé ! Relance : npm run dev -- --host"
