#!/bin/bash

echo "🧹 Nettoyage des blocs de test visibles restants..."

# Supprimer les lignes contenant le message de test ou bloc fantôme
find ./src -type f -name "*.jsx" -exec sed -i '/TEST DE CONTENU RENDU/d' {} +
find ./src -type f -name "*.jsx" -exec sed -i '/APP LOADED/d' {} +
find ./src -type f -name "*.jsx" -exec sed -i '/LES COMPOSANTS SONT MORTS OU INVISIBLES/d' {} +

# Supprimer les composants <Test /> ou <DevCheck />
find ./src -type f -name "*.jsx" -exec sed -i '/<Test/d;/<DevCheck/d;/VisibleDebug/d' {} +

# Supprimer les fragments inutiles laissés vides
find ./src -type f -name "*.jsx" -exec sed -i '/<><\/>/d' {} +

# Éventuellement nettoyer aussi les balises <div> contenant uniquement du texte de debug
find ./src -type f -name "*.jsx" -exec sed -i '/<div>.*DEBUG.*<\/div>/d' {} +

# Rappel : build et redeploy si tout est ok
echo "✅ Nettoyage des composants de test terminé."

echo "🔁 Build en cours pour s'assurer que tout est clean..."
npm run build

echo "🟢 Si tout est ok, tu peux relancer : bash scripts/deploy-luxeevents.sh"
