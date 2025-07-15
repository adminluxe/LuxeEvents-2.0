#!/usr/bin/env bash
set -euo pipefail

FILE="src/components/Map.jsx"
if [[ ! -f "$FILE" ]]; then
  echo "❌ $FILE introuvable !"
  exit 1
fi

echo "🔧 Nettoyage des imports en double dans $FILE…"

# 1) On supprime toute ligne en double « import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet' »
sed -i "/import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet'/{
  # ne garder que la première occurrence, supprimer les suivantes
  x; /^seen$/d; x; b; 
  x; s/.*/seen/; x;
}" "$FILE"

# 2) On supprime l'import CSS dupliqué
#    (on garde une seule ligne import 'leaflet/dist/leaflet.css';)
sed -i "/import 'leaflet\/dist\/leaflet.css'/{
  x; /^seenCSS$/d; x; b;
  x; s/.*/seenCSS/; x;
}" "$FILE"

# 3) (optionnel) Reformater pour avoir les imports ESM en tête de fichier
#    On s'assure qu'on a au moins une fois chacun :
grep -q "import 'leaflet/dist/leaflet.css'" "$FILE" || \
  sed -i "1iimport 'leaflet/dist/leaflet.css';" "$FILE"
grep -q "import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet'" "$FILE" || \
  sed -i "1iimport { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';" "$FILE"

echo "✅ Imports uniques en place. Lance la dev pour vérifier : pnpm run dev"
