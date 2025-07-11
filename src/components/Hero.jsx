import React from 'react';
import Lottie from 'lottie-react';
import logoAnimation from '../media/logo.json';
import { useTranslation } from 'react-i18next';

export default function Hero() {
  const { t } = useTranslation();

  return (
    <div className="hero-container relative overflow-hidden h-screen flex flex-col items-center justify-center bg-black">
      {/* Animation Lottie en haut */}
      <div className="logo-container mb-8" style={{ width: 200, height: 200 }}>
        <Lottie 
          animationData={logoAnimation} 
          loop 
          autoplay 
        />
      </div>

      {/* Texte hero */}
      <h1 className="text-4xl md:text-6xl text-ivory text-center px-4">
        {t('welcome')}
      </h1>
      <button className="mt-6 px-6 py-3 bg-gold text-black font-semibold rounded-lg">
        {t('cta')}
      </button>
    </div>
  );
}
