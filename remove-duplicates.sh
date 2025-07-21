#!/bin/bash

# Dossier de travail
PROJECT_DIR="~/luxeevents-frontend"

# Rechercher dans tous les fichiers .jsx du projet les doublons de "Médias", "Services" et "Devis"
echo "🔍 Recherche des doublons dans les fichiers .jsx..."

# Recherche et suppression des doublons pour chaque section spécifique
for file in $(find $PROJECT_DIR/src -name "*.jsx"); do
  echo "Vérification de $file..."

  # Vérifier la présence des doublons "Media", "Services" et "Devis"
  grep -q "href=\"/media\"" "$file" && echo "Doublon Media trouvé dans $file"
  grep -q "href=\"/devis\"" "$file" && echo "Doublon Devis trouvé dans $file"
  grep -q "href=\"/services\"" "$file" && echo "Doublon Services trouvé dans $file"

  # Supprimer les doublons dans chaque fichier si trouvés
  sed -i '/href="\/media"/{N;/\n.*href="\/media"/d;}' "$file"   # Supprimer doublon Media
  sed -i '/href="\/devis"/{N;/\n.*href="\/devis"/d;}' "$file"     # Supprimer doublon Devis
  sed -i '/href="\/services"/{N;/\n.*href="\/services"/d;}' "$file" # Supprimer doublon Services
done

echo "✅ Doublons supprimés si trouvés. Veuillez vérifier les fichiers pour confirmation."
