#!/bin/bash

echo "🔁 Restauration de l'expérience immersive LuxeEvents..."

cat << 'EOC' > src/App.jsx
import React from 'react';
import HeroSection from './components/HeroSection';
import IntroAnimationLottie from './components/IntroAnimationLottie';
import StorySwiper from './components/StorySwiper';
import TimelineMagique from './components/TimelineMagique';
import QuoteForm from './components/QuoteForm';
import FooterLuxe from './components/FooterLuxe';
import AudioAmbient from './components/AudioAmbient';
import FadeUpWrapper from './components/FadeUpWrapper';

function App() {
  return (
    <>
      <AudioAmbient />
      <IntroAnimationLottie />
      <FadeUpWrapper>
        <HeroSection />
        <StorySwiper />
        <TimelineMagique />
        <QuoteForm />
        <FooterLuxe />
      </FadeUpWrapper>
    </>
  );
}

export default App;
EOC

echo "✅ App.jsx restauré avec composants immersifs."

# Rebuild + Deploy
echo "🚀 Build en cours..."
pnpm run build || npm run build

echo "🌐 Déploiement Vercel en cours..."
vercel --prod

echo "✅ Terminé. LuxeEvents est de retour."
