#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Correction des imports relatifs dans src/pages/*.jsx…"

# Pour chaque page .jsx
find src/pages -type f -name "*.jsx" | while read PAGE; do
  echo "→ Traitement de $PAGE"

  # 1) Layout
  sed -i -E \
    "s|import ([[:alnum:]]+) from ['\"][./]+components/Layout(['\"])|import \1 from \"../components/Layout.jsx\"|g" \
    "$PAGE"

  # 2) Carousel
  sed -i -E \
    "s|import ([[:alnum:]]+) from ['\"][./]+components/Carousel(['\"])|import \1 from \"../components/Carousel.jsx\"|g" \
    "$PAGE"

  # 3) Testimonials
  sed -i -E \
    "s|import ([[:alnum:]]+) from ['\"][./]+components/Testimonials(['\"])|import \1 from \"../components/Testimonials.jsx\"|g" \
    "$PAGE"
done

echo "✅ Tous les imports ont été corrigés."
echo "→ Relance vite : pnpm run dev"
