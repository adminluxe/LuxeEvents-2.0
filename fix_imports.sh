#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Remplacement des imports '@/components/Layout' par '../components/Layout' dans src/pages…"
find src/pages -type f -name "*.jsx" -print0 \
  | xargs -0 sed -i "s|@/components/Layout|../components/Layout|g"

echo "🔧 Pareil pour Carousel & Testimonials"
find src/pages -type f -name "*.jsx" -print0 \
  | xargs -0 sed -i "s|@/components/Carousel|../components/Carousel|g"
find src/pages -type f -name "*.jsx" -print0 \
  | xargs -0 sed -i "s|@/components/Testimonials|../components/Testimonials|g"

echo "✅ Imports fixés, relance vite !"
