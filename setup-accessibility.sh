#!/usr/bin/env bash
set -euo pipefail

echo "♿ Démarrage du setup Accessibilité…"

# 1) Installer les dépendances d’a11y
echo "1) Installation de eslint-plugin-jsx-a11y et axe-core…"
npm install --save-dev eslint-plugin-jsx-a11y axe-core

# 2) Configurer ESLint pour l’accessibilité
echo "2) Ajout du plugin a11y dans .eslintrc.js…"
if ! grep -q "jsx-a11y" .eslintrc.js; then
  sed -i "/plugins:/a \    'jsx-a11y'," .eslintrc.js
  sed -i "/extends:/a \    'plugin:jsx-a11y/recommended'," .eslintrc.js
  echo " • Plugin JSX a11y activé dans ESLint"
else
  echo " • JSX a11y déjà configuré"
fi

# 3) Injection d'attributs ARIA basiques
echo "3) Patch Hero.jsx et ReservationForm.jsx…"
# Hero : ajouter role="banner" et aria-label
sed -i "/<header /a \  role=\"banner\" aria-label=\"Section héroïque Luxeevents\"" src/components/landing/Hero.jsx

# Formulaire : ajouter role="form" et aria-describedby pour le date-picker
sed -i "/<form /a \  role=\"form\" aria-describedby=\"reservation-desc\"" src/pages/ReservationForm.jsx
sed -i "/<DatePicker /a \  aria-label=\"Sélection de la date de réservation\"" src/pages/ReservationForm.jsx

# 4) Audit automatisé avec axe-core
echo "4) Lancement d’un audit a11y rapide (Node script)…"
tee scripts/run-axe.js > /dev/null << 'EOF'
const { readFileSync } = require('fs');
const { JSDOM } = require('jsdom');
const axe = require('axe-core');

(async () => {
  const html = readFileSync('public/index.html', 'utf8');
  const dom = new JSDOM(html);
  const { window } = dom;
  const results = await axe.run(window.document);
  console.log('\n🔍 Résultats a11y :');
  results.violations.forEach(v => {
    console.log(`\n• [${v.id}] ${v.help}`);
    v.nodes.forEach(node => console.log('   -', node.target.join(', ')));
  });
})();
EOF
echo " • Script d’audit disponible : `node scripts/run-axe.js`"

# 5) Conseils complémentaires
echo -e "\n✅ Accessibilité de base déployée !  
→ Maintenant, :  
  • Lance `npm run lint` pour voir les alertes JSX-a11y.  
  • Exécute `node scripts/run-axe.js` pour un audit rapide sur ton index.html.  
  • Teste manuellement au clavier (Tab, Shift+Tab) et avec un lecteur d’écran.  
→ Pour aller plus loin, on pourra prévoir des sessions utilisateurs et un rapport détaillé WCAG. 🚀"
