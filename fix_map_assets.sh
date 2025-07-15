#!/usr/bin/env bash
set -euo pipefail
FILE="src/components/Map.jsx"

# 1) Inject imports for the three images (if absent)
grep -q "import iconRetinaUrl" "$FILE" || sed -i "2iimport iconRetinaUrl from 'leaflet/dist/images/marker-icon-2x.png';\nimport iconUrl       from 'leaflet/dist/images/marker-icon.png';\nimport iconShadowUrl from 'leaflet/dist/images/marker-shadow.png';\n" "$FILE"

# 2) Remove the three require(...) lines
sed -i "/require('leaflet\/dist\/images\/marker-icon-2x.png')/d" "$FILE"
sed -i "/require('leaflet\/dist\/images\/marker-icon.png')/d" "$FILE"
sed -i "/require('leaflet\/dist\/images\/marker-shadow.png')/d" "$FILE"

# 3) Replace mergeOptions block keys
sed -i "/L.Icon.Default.mergeOptions({/,/})/{
  s/iconRetinaUrl:.*/iconRetinaUrl,/
  s/iconUrl:.*/iconUrl,/
  s/shadowUrl:.*/shadowUrl: iconShadowUrl,/
}" "$FILE"

echo "✅ Map.jsx patched – relance vite: pnpm run dev"
