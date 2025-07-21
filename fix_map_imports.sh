#!/usr/bin/env bash
set -euo pipefail

FILE="src/components/Map.jsx"
if [[ ! -f "$FILE" ]]; then
  echo "❌ $FILE introuvable !"
  exit 1
fi

echo "🔧 Nettoyage des imports MapContainer/leaflet.css…"

# 1) on supprime les imports en double
sed -i "/import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet'/d" "$FILE"
sed -i "/import 'leaflet\/dist\/leaflet.css'/d" "$FILE"

# 2) on réinjecte proprement, en tête de fichier
sed -i "1iimport { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';" "$FILE"
sed -i "1iimport 'leaflet/dist/leaflet.css';" "$FILE"

echo "✅ Imports nettoyés et réinjectés."
echo "Relance vite la dev : pnpm run dev"
