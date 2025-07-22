#!/bin/bash

echo "🔧 Correction automatique des erreurs dans le projet LuxeEvents..."

# 1. Corriger l'importation de `i18next` dans `src/i18n.js`
echo "⚙️ Correction de l'import de i18next..."
sed -i 's|import i18next from "i18next";|import i18next from "i18next";|' src/i18n.js

# 2. Supprimer les propriétés CSS obsolètes (-moz-*)
echo "⚙️ Suppression des propriétés CSS obsolètes (-moz-*)..."
sed -i '/-moz-/d' src/styles/index.css || echo "Aucun fichier CSS trouvé"
sed -i '/orphans/d' src/styles/index.css || echo "Aucun fichier CSS trouvé"
sed -i '/widows/d' src/styles/index.css || echo "Aucun fichier CSS trouvé"

# 3. Ajouter "type": "module" dans `package.json` pour éviter les avertissements
echo "⚙️ Ajout de 'type': 'module' dans package.json..."
sed -i '/"name": "luxeevents"/a "type": "module",' package.json

# 4. Mettre à jour la version de `lottie-web` dans `package.json`
echo "⚙️ Mise à jour de `lottie-web` dans package.json..."
sed -i 's|"lottie-web": ".*"|"lottie-web": "^5.13.0"|' package.json

# 5. Ajouter la dépendance manquante `eslint-plugin-jsx-a11y`
echo "⚙️ Installation de eslint-plugin-jsx-a11y..."
pnpm add -D eslint-plugin-jsx-a11y

# 6. Ajouter `@vitejs/plugin-react` dans les dépendances si nécessaire
echo "⚙️ Vérification de la dépendance @vitejs/plugin-react..."
pnpm add -D @vitejs/plugin-react

echo "✅ Toutes les corrections ont été appliquées. Veuillez tester localement..."

# 7. Lancer le build localement pour tester
pnpm run build

echo "🔄 Tout est prêt, faites un commit et un push vers GitHub."
