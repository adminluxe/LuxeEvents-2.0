#!/usr/bin/env bash
set -euo pipefail
FILE="src/components/Map.jsx"

# 1) Supprimer l'import de motion et renderToString
sed -i "/import { motion } from 'framer-motion'/d" \$FILE
sed -i "/import { renderToString } from 'react-dom\\/server'/d" \$FILE

# 2) Remplacer la fonction LuxuryIcon pour utiliser un SVG statique + CSS
sed -i "/function LuxuryIcon/,/})/c\\
function LuxuryIcon(color = '#CBA135') {\\
  const html = \`<svg class=\"luxury-pulse\" width=\"32\" height=\"32\" viewBox=\"0 0 24 24\" fill=\"\${color}\" xmlns=\"http://www.w3.org/2000/svg\">\\
    <path d=\"M12 2L15 8H9L12 2Z\"/>\\
  </svg>\`\\
  return L.divIcon({ className: 'luxury-marker', html, iconSize: [32, 32] })\\
}" \$FILE

# 3) Injecter le CSS d'animation en haut du fichier (si pas déjà présent)
grep -q "luxury-pulse" \$FILE || sed -i "1iimport '@/styles/map-animations.css'" \$FILE

echo "✅ Map.jsx patché en fallback SSR. Ajoutez \`map-animations.css\` et relancez : pnpm run dev"
