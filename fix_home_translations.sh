#!/usr/bin/env bash
# fix_home_translations.sh — Injecte servicesTitle & assure tableaux dans tous vos JSON de trad
set -euo pipefail

# 1) Dans public/locales/{fr,en}/fr.json & en.json
for FILE in public/locales/*/*.json; do
  echo "🔧 Traitement \$FILE…"
  tmp="\$FILE.tmp"
  jq '
    .title         //= "Accueil"   |
    .servicesTitle //= "Services"  |
    .features      |= (if type=="array" then . else [] end) |
    .services      |= (if type=="array" then . else [] end)
  ' "\$FILE" > "\$tmp" && mv "\$tmp" "\$FILE"
  echo "✅ MàJ \$FILE"
done

# 2) Dans src/locales/{fr.json,en.json}
for FILE in src/locales/*.json; do
  echo "🔧 Traitement \$FILE…"
  tmp="\$FILE.tmp"
  jq '
    .title         //= "Accueil"   |
    .servicesTitle //= "Services"  |
    .features      |= (if type=="array" then . else [] end) |
    .services      |= (if type=="array" then . else [] end)
  ' "\$FILE" > "\$tmp" && mv "\$tmp" "\$FILE"
  echo "✅ MàJ \$FILE"
done

echo "🎉 Toutes les traductions sont à jour."
