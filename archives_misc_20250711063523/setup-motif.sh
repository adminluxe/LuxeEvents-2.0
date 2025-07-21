#!/usr/bin/env bash
set -e

# 1) Crée le dossier public/media s’il n’existe pas
mkdir -p public/media

# 2) Écris le SVG optimisé
cat > public/media/motif.svg << 'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="120" height="120" viewBox="0 0 120 120" fill="none">
  <defs>
    <pattern id="floralPattern" patternUnits="userSpaceOnUse" width="120" height="120">
      <g stroke="#D4AF37" stroke-width="1.2" fill="#F8F5F0">
        <!-- Fleur stylisée -->
        <path d="M60 10c5 15 25 15 30 0-5 15 5 35 20 30-15 5-15 25 0 30-15-5-35 5-30 20-5-15-25-15-30 0 5-15-5-35-20-30 15-5 15-25 0-30 15 5 35-5 30-20z"/>
        <!-- Centre de la fleur -->
        <circle cx="60" cy="60" r="3" fill="#D4AF37"/>
      </g>
    </pattern>
  </defs>
  <!-- Fond noir -->
  <rect width="100%" height="100%" fill="#000"/>
  <!-- Motif ivoire/or -->
  <rect width="100%" height="100%" fill="url(#floralPattern)"/>
</svg>
SVG

echo "✅ public/media/motif.svg créé avec la palette or / ivoire / noir."
echo
echo "→ Maintenant :"
echo "   pnpm run build"
echo "   vercel build --prod --yes && vercel --prebuilt --prod --yes"
echo "Puis, n’oublie pas de purger Cloudflare et de hard-refresh."
