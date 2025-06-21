#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'clean_html'. Description à compléter.
SRC="public/index.html"
TMP="public/index.tmp.html"

echo "🔧 Nettoyage de $SRC…"

# 1. Supprime les doublons de <link rel="icon"> et <link rel="manifest">
awk '!x[$0]++' "$SRC" \
  | sed '/<link rel="icon" href=\"\/favicon.ico\" \/>/d' \
  | sed '/<link rel="manifest" href=\"\/manifest.json\" \/>/d' \
  > "$TMP"

# 2. Réinsère une seule fois les liens essentiels
sed -i '3i\
    <link rel="icon" href="/favicon.ico" />\
    <link rel="manifest" href="/manifest.json" />' "$TMP"

# 3. Remplace la source du script pour éviter %PUBLIC_URL%
sed -i 's|<link rel="icon" href="%PUBLIC_URL%/favicon.ico">||g' "$TMP"

# 4. Renomme
mv "$TMP" "$SRC"
echo "✅ $SRC nettoyé."
