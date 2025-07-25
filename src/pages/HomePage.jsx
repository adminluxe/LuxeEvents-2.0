import React from 'react';
import { Helmet } from 'react-helmet-async';
import HeroSection from '../components/HeroSection';
import StorySwiper from '../components/StorySwiper';
import TimelineMagique from '../components/TimelineMagique';
import QuoteForm from '../components/QuoteForm';
import FooterLuxe from '../components/FooterLuxe';
import FadeUpWrapper from '../components/FadeUpWrapper';

export default function HomePage() {
  return (
    <>
      <Helmet>
        <title>LuxeEvents – Sublimez votre événement</title>
        <meta name="description" content="Page d'accueil immersive de LuxeEvents – Événements haut de gamme." />
        <meta property="og:title" content="LuxeEvents – Sublimez votre événement" />
        <meta property="og:image" content="/og_default.jpg" />
      </Helmet>

      <div style={{ padding: '2rem', color: '#fff', backgroundColor: '#111' }}>
        ✅ TEST DE CONTENU RENDU - SI TU VOIS CECI, LES COMPOSANTS SONT MORTS OU INVISIBLES
      </div>

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
