#!/usr/bin/env bash
# Déplace mapTitle et servicesTitle dans home.{…}

set -euo pipefail

for FILE in public/locales/fr/fr.json public/locales/en/en.json src/locales/fr.json src/locales/en.json; do
  echo "🔧 Correction de la structure dans \$FILE…"
  tmp="\$FILE.tmp"
  jq '
    # 1) On extrait mapTitle et servicesTitle depuis la racine (s’ils existent)
    .home += {
      mapTitle:      (.mapTitle      // .home.mapTitle // empty),
      servicesTitle: (.servicesTitle // .home.servicesTitle // empty)
    } |
    # 2) On supprime ces clés à la racine
    del(.mapTitle, .servicesTitle)
  ' "\$FILE" > "\$tmp" && mv "\$tmp" "\$FILE"
done

echo "✅ mapTitle et servicesTitle sont maintenant sous home.*"
