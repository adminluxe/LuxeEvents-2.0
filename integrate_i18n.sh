#!/usr/bin/env bash
set -euo pipefail

echo "🌐 Intégration i18n dans src/pages/*.jsx…"

for FILE in src/pages/*.jsx; do
  [ -f "$FILE" ] || continue

  # import hook
  if ! grep -q "useTranslation" "$FILE"; then
    sed -i '1s|^|import { useTranslation } from "react-i18next";\n|' "$FILE"
  fi

  # clé page
  key=$(basename "$FILE" .jsx | tr '[:upper:]' '[:lower:]')

  # titre / intro
  sed -i -E \
    -e "s|<h1([^>]*)>[^<]+</h1>|<h1\1>{t(\"$key.title\")}</h1>|g" \
    -e "s|<p([^>]*)>[^<]+</p>|<p\1>{t(\"$key.intro\")}</p>|1" \
    "$FILE"

  echo "→ i18n injecté dans $FILE"
done

# main.jsx
if ! grep -q "import './i18n'" src/main.jsx; then
  sed -i "1s|^|import './i18n';\n|" src/main.jsx
  echo "→ import './i18n' ajouté dans src/main.jsx"
fi
