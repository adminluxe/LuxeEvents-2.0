import HashScroller from "./components/HashScroller";
import React from "react";
import { Routes, Route } from "react-router-dom";

import ThemeProvider from "./theme/ThemeProvider.jsx";
import SeoHead from "./components/SeoHead.jsx";
import HeroSection from "./components/HeroSection.jsx";
import ServicesSection from "./components/ServicesSection.jsx";
import TestimonialsCarousel from "./components/TestimonialsCarousel.jsx";
import TrustBadges from "./components/TrustBadges.jsx";
import DevisLanding from "./components/DevisLanding.jsx";
import APropos from "./pages/APropos.jsx";
import MentionsLegales from "./pages/MentionsLegales.jsx";
import PolitiqueConfidentialite from "./pages/PolitiqueConfidentialite.jsx";
import Realisations from "./pages/Realisations.jsx";
import FAQ from "./pages/FAQ.jsx";

import { SchemaHome } from "./components/SchemaSite.jsx";

function HomePage() {
  return (
    <main className="min-h-screen bg-[#0b0b0b] text-white">
      <SeoHead
        title="LuxeEvents – Événements & mariages haut de gamme"
        description="LuxeEvents orchestre vos événements privés et corporate avec luxe, innovation et élégance. Basés à Paris, nous intervenons en France et à l’international."
        canonical="https://luxeevents.me/"
      />
      <SchemaHome />
      <HeroSection />
      <section><ServicesSection /></section>
      <section><TestimonialsCarousel /></section>
      <section id="confiance"><TrustBadges /></section>
    </main>
  );
}

const Shell = ({ children }) => (
  <>
{children}
  </>
);

export default function App() {
  return (
    <ThemeProvider>
      <Shell>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/devis" element={<DevisLanding />} />
          <Route path="/realisations" element={<Realisations />} />
          <Route path="/faq" element={<FAQ />} />
          <Route path="/a-propos" element={<APropos />} />
          <Route path="/mentions-legales" element={<MentionsLegales />} />
          <Route path="/politique-confidentialite" element={<PolitiqueConfidentialite />} />
          <Route path="*" element={<HomePage />} />
        </Routes>
      </Shell>
    </ThemeProvider>
  );
}
