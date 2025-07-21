#!/bin/bash
echo "🔍 Vérification des fichiers > 100 Mo..."

find . -type f -size +100M | grep -v '.git/' > large_files.txt

if [[ -s large_files.txt ]]; then
  echo "🚫 Fichiers trop lourds détectés :"
  cat large_files.txt
  echo "❌ Push annulé pour éviter une erreur GitHub."
  exit 1
else
  echo "✅ Aucun fichier > 100 Mo trouvé. Tu peux push tranquille."
  exit 0
fi
