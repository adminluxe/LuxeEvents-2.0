#!/bin/bash

echo "🔧 Correction automatique des erreurs JSX signalées par ESLint..."

# 1. CircularMenu.jsx – wrap adjacent elements with fragment <>
sed -i '/return (\s*$/,/);/s/^\(\s*\)<\([^>]\)/\1<>\n\1<\2/;s/\(\s*\)<\/[^>]*>/\1<\/>\n&/' src/components/CircularMenu.jsx

# 2. CircularNav.jsx – nettoyage caractères invisibles ligne 45
sed -i '45s/[^[:print:]]//g' src/components/CircularNav.jsx

# 3. FadeUpWrapper.jsx – nettoyage caractères invisibles ligne 6
sed -i '6s/[^[:print:]]//g' src/components/FadeUpWrapper.jsx

# 4. Footer.jsx – supprimer déclaration en double de Link (ligne 2)
sed -i '/^import Link from .*next\/link.*$/!b;n;/const Link *=/d' src/components/Footer.jsx

# 5. RequestQuotePage.jsx – clôture JSX oubliée ligne 11
sed -i '11s/$/ <\/div>/' src/pages/RequestQuotePage.jsx

# 6. ServicesPage.jsx – clôture JSX oubliée ligne 12
sed -i '12s/$/ <\/div>/' src/pages/ServicesPage.jsx

echo "✅ Corrections appliquées. Tu peux relancer ESLint pour valider :"
echo "   npx eslint --config eslint.config.cjs src/ --max-warnings=0 --fix"
