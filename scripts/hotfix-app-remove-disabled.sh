#!/bin/bash

echo "🛠️ Hotfix App.jsx : suppression des composants DISABLED importés..."

APP_FILE="src/App.jsx"

# Récupérer tous les composants désactivés (basename sans extension)
DISABLED_COMPONENTS=$(find src/components -name "*.DISABLED" | sed -E 's|.*/(.*)\.jsx\.DISABLED|\1|' | sort -u)

for component in $DISABLED_COMPONENTS; do
  echo "❌ Suppression de $component dans $APP_FILE"
  # Supprimer import
  sed -i "/$component/d" "$APP_FILE"
  # Supprimer JSX (ligne qui appelle le composant en JSX)
  sed -i "/<$component/d" "$APP_FILE"
done

echo "✅ App.jsx nettoyé de tous les composants DISABLED"
