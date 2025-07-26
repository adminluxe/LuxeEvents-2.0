#!/bin/bash

echo "🕺 COMBO FINAL MOONWALK – LUXEEVENTS – $(date +'%Y-%m-%d %H:%M:%S')"
echo "✨ Nettoyage de tous les résidus parasites avant décollage..."

# 1. Suppression des artefacts Vercel/Vite
rm -rf .vercel/cache dist .next .output node_modules/.vite

# 2. Restauration des composants clés (depuis backup sains)
mkdir -p ~/safe_components_disabled
RESTORE_LIST=(
  HeroSection.jsx
  ServicesSection.jsx
  QuoteForm.jsx
  TimelineSection.jsx
  SwipeStory.jsx
  Footer.jsx
)
for file in "${RESTORE_LIST[@]}"; do
  if [ -f ~/safe_components_disabled/$file.DISABLED ]; then
    echo "♻️ Restauration de $file"
    cp ~/safe_components_disabled/$file.DISABLED src/components/$file
  fi
done

# 3. Réécriture propre du App.jsx
cat << 'EOL' > src/App.jsx
import React from 'react';
import HeroSection from './components/HeroSection';
import ServicesSection from './components/ServicesSection';
import QuoteForm from './components/QuoteForm';
import TimelineSection from './components/TimelineSection';
import SwipeStory from './components/SwipeStory';
import Footer from './components/Footer';

function App() {
  return (
    <>
      <HeroSection />
      <ServicesSection />
      <QuoteForm />
      <TimelineSection />
      <SwipeStory />
      <Footer />
    </>
  );
}

export default App;
EOL

# 4. Correction automatique des fragments JSX cassés
echo "🔧 Vérification et patch automatique des fragments JSX..."
for file in "${RESTORE_LIST[@]}"; do
  path="src/components/$file"
  if grep -q '</>' "$path"; then
    sed -i 's|</>||g' "$path"
  fi
  if ! grep -q "<>" "$path"; then
    sed -i '/return (/a \    <>' "$path"
    sed -i '/);/i \    </>' "$path"
  fi
done

# 5. Dernière vérif : suppression des anciens textes de debug
echo "🚫 Suppression des balises parasites restantes..."
sed -i '/VISIBLE:/d' src/components/*.jsx src/App.jsx || true

# 6. Rebuild complet
echo "🏗️ Rebuild Vite propre..."
npm run build || {
  echo "❌ Build échoué. Abort mission."
  exit 1
}

# 7. Déploiement final
echo "🚀 Déploiement Vercel propre et forcé..."
vercel --prod --force --yes || {
  echo "❌ Déploiement échoué. Check Vercel CLI."
  exit 1
}

echo "✅ Déploiement complet. 🌕 Moonwalk validé. CTRL+F5 si cache persistant."
