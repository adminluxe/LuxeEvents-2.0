
#!/bin/bash

echo "🧼 Lancement du nettoyage global LuxeEvents..."

# 1. Commenter smartlook avec mauvaise clé
echo "🔧 Nettoyage de Smartlook..."
find src/ -type f -name '*.js' -o -name '*.jsx' | while read file; do
  sed -i 's|smartlook(\'init\', \"TO_REPLACE_WITH_SMARTLOOK_KEY\"|// smartlook disabled|' "$file"
  sed -i "s|smartlook('init', 'TO_REPLACE_WITH_SMARTLOOK_KEY'|// smartlook disabled|" "$file"
done

# 2. Suppression du cdn.tailwindcss.com
echo "🚫 Suppression de cdn.tailwindcss.com..."
find . -type f -name "*.html" -exec sed -i '/cdn\.tailwindcss\.com/d' {} \;

# 3. Correction des balises mal fermées ou avec src="{src}" (quotes autour des variables JSX)
echo "✅ Correction des balises <img src="{src}" /> → <img src={src} />"
grep -rl 'src="{[^"]*}"' src/ | while read file; do
  sed -i -E 's/src="\{([^"]*)\}"/src={\1}/g' "$file"
done

# 4. Vérification des balises <img> cassées
echo "🔍 Analyse des images cassées dans le code JSX..."
grep -r '<img[^>]*src=' src/ | grep -vE 'placeholder|default' || echo "✅ Aucun usage d’image cassée détecté"

echo "🧪 Reconstruction du projet..."
pnpm run build

echo "🚀 Prêt pour redeploy si build OK."
