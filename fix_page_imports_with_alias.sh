#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Remise à zéro des imports de Layout, Carousel & Testimonials dans src/pages/*.jsx…"

find src/pages -type f -name "*.jsx" | while read PAGE; do
  echo "→ Traitement de $PAGE"

  # Layout
  sed -i -E \
    "s|import [[:alnum:]]+ from ['\"][./@]+components/Layout(\.jsx)?['\"];?|import Layout from '@/components/Layout';|g" \
    "$PAGE"

  # Carousel
  sed -i -E \
    "s|import [[:alnum:]]+ from ['\"][./@]+components/Carousel(\.jsx)?['\"];?|import Carousel from '@/components/Carousel';|g" \
    "$PAGE"

  # Testimonials
  sed -i -E \
    "s|import [[:alnum:]]+ from ['\"][./@]+components/Testimonials(\.jsx)?['\"];?|import Testimonials from '@/components/Testimonials';|g" \
    "$PAGE"
done

echo "✅ Imports corrigés, relancez votre dev : pnpm run dev"
