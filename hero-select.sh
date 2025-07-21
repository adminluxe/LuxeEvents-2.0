#!/bin/bash
echo "📂 Liste des images de fond disponibles :"
find public/media/images -name "photo-*.webp" | sort
echo ""
echo "🔍 Affichez-les avec :"
echo "xdg-open public/media/images/photo-XXX.webp"
