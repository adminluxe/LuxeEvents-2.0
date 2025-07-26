#!/bin/bash

echo "🩺 Restauration du cœur de l'interface..."

# Étape 1 : Restaurer les composants essentiels
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
    cp ~/safe_components_disabled/$file.DISABLED "src/components/$file"
  fi
done

# Étape 2 : Réinjecter dans App.jsx les bons composants
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

echo "✅ Composants restaurés. Rebuild en cours..."
npm run build && vercel --prod --force

echo "🎯 Site relancé avec les composants essentiels visibles."
