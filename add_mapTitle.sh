#!/usr/bin/env bash
# add_mapTitle.sh — Injecte mapTitle dans tous les JSON de traductions

set -euo pipefail

# 1) JSON publics
for FILE in public/locales/fr/fr.json public/locales/en/en.json; do
  echo "🔧 Injection de mapTitle dans $FILE"
  tmp="$FILE.tmp"
  jq '
    .mapTitle   //= (if . == . and env.LANG == "fr" then "Nos événements" else "Our Events" end)
  ' "$FILE" > "$tmp" && mv "$tmp" "$FILE"
done

# 2) JSON dans src/locales
for FILE in src/locales/fr.json src/locales/en.json; do
  echo "🔧 Injection de mapTitle dans $FILE"
  tmp="$FILE.tmp"
  jq '
    .mapTitle   //= (if . == . and env.LANG == "fr" then "Nos événements" else "Our Events" end)
  ' "$FILE" > "$tmp" && mv "$tmp" "$FILE"
done

echo "✅ Toutes les traductions ont maintenant la clé mapTitle."
