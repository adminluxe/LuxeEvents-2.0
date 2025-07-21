#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Fix des imports dans src/pages : ajout de l’extension .jsx"

# Layout
find src/pages -type f -name "*.jsx" -print0 \
  | xargs -0 sed -i "s|from \"\(\.\.\)/components/Layout\"|from \"\1/components/Layout.jsx\"|g"

# Carousel
find src/pages -type f -name "*.jsx" -print0 \
  | xargs -0 sed -i "s|from \"\(\.\.\)/components/Carousel\"|from \"\1/components/Carousel.jsx\"|g"

# Testimonials
find src/pages -type f -name "*.jsx" -print0 \
  | xargs -0 sed -i "s|from \"\(\.\.\)/components/Testimonials\"|from \"\1/components/Testimonials.jsx\"|g"

echo "✅ Imports corrigés, relance vite !"
