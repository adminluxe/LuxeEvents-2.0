#!/bin/bash

mkdir -p src/assets/audio

ffmpeg -i /home/tontoncestcarre/uploads/medias_final/ambiance-luxe.mp4 \
       -vn -acodec libmp3lame -q:a 2 \
       src/assets/audio/ambiance-luxe.mp3

echo "✅ Audio extrait dans src/assets/audio/ambiance-luxe.mp3"
