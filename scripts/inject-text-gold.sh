#!/bin/bash
CSS_FILE=$(find src -name "*.css" | head -n1)

if grep -q ".text-gold" "$CSS_FILE"; then
  echo "✅ .text-gold déjà présent dans $CSS_FILE"
else
  echo "✨ Injection de .text-gold dans $CSS_FILE"
  sed -i '/^@tailwind utilities;/a\
\n/* === LuxeEvents Custom Classes === */\
.text-gold {\n  color: #f8e9c8;\n}' "$CSS_FILE"
fi
