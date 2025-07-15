#!/usr/bin/env bash
# fix_home_translations.sh — Injection de servicesTitle & tableaux dans home.json
set -euo pipefail

# On cible désormais le bon répertoire
LOCALES_DIR="public/locales"

for LANG_DIR in "$LOCALES_DIR"/*; do
  FILE="$LANG_DIR/home.json"
  if [[ ! -f "$FILE" ]]; then
    echo "⚠️ $FILE introuvable, je passe."
    continue
  fi

  echo "🔧 Traitement de $FILE…"

  tmp="$FILE.tmp"
  jq '
    .title         //= "Accueil"   |
    .servicesTitle //= "Services"  |
    .features      |= (if type=="array" then . else [] end) |
    .services      |= (if type=="array" then . else [] end)
  ' "$FILE" > "$tmp" && mv "$tmp" "$FILE"

  echo "✅ Clés injectées dans $FILE"
done

echo "🎉 Toutes les locales sous $LOCALES_DIR sont maintenant à jour."
