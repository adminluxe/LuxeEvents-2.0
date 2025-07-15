#!/usr/bin/env bash
set -euo pipefail

echo "🔄 Normalisation des imports dans src/pages/*.jsx…"

find src/pages -type f -name "*.jsx" -print0 | while IFS= read -r -d '' FILE; do
  echo "→ $FILE"

  # Layout
  sed -i -E \
    "s|import[[:space:]]+[A-Za-z0-9_]+[[:space:]]+from[[:space:]]+['\"][^'\"]*components/Layout(\.jsx)?['\"];?|import Layout from '@/components/Layout';|g" \
    "$FILE"

  # Carousel
  sed -i -E \
    "s|import[[:space:]]+[A-Za-z0-9_]+[[:space:]]+from[[:space:]]+['\"][^'\"]*components/Carousel(\.jsx)?['\"];?|import Carousel from '@/components/Carousel';|g" \
    "$FILE"

  # Testimonials
  sed -i -E \
    "s|import[[:space:]]+[A-Za-z0-9_]+[[:space:]]+from[[:space:]]+['\"][^'\"]*components/Testimonials(\.jsx)?['\"];?|import Testimonials from '@/components/Testimonials';|g" \
    "$FILE"
done

echo "✅ Imports normalisés !"
