#!/bin/bash

echo "✨ Injection du script Lottie <lottie-player> dans index.html..."

TARGET="index.html"

if grep -q "lottiefiles/lottie-player" "$TARGET"; then
  echo "⚠️  Le script Lottie est déjà présent dans $TARGET. Rien à faire."
else
  sed -i '/<\/head>/i \  <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"><\/script>' "$TARGET"
  echo "✅ Script <lottie-player> injecté juste avant </head> dans $TARGET."
fi
