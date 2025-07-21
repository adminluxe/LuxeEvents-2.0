#!/bin/bash

# Rechercher tous les fichiers contenant "motion.div" dans le projet
for file in $(find ~/luxeevents-frontend/src -name "*.jsx"); do
  echo "Modification de $file..."

  # Ajoute "relative" dans la classe de motion.div
  sed -i 's/className=".*motion.div.*/className=".*motion.div.*relative/' "$file"
done

echo "✅ Modification des fichiers terminée"
