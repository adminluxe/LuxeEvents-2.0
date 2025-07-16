#!/bin/bash

echo "🔎 Sentinelle active : Recherche de doublons pour Media / Devis / Services / Médias"
echo "-------------------------------------------------------------"

SEARCH_TERMS=("Media" "Médias" "Devis" "Services")
SRC_DIR="src"

for term in "${SEARCH_TERMS[@]}"; do
  echo -e "\n🔍 Recherche : \"$term\""
  grep -rn --color=always --include=\*.{js,jsx,ts,tsx} "$term" "$SRC_DIR"
done

echo -e "\n✅ Fin de l’analyse."
echo "-------------------------------------------------------------"
