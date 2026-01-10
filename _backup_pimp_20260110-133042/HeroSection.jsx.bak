import React from "react";
import RevealOnScroll from "./RevealOnScroll.jsx";
import LuxeParallax from "./LuxeParallax.jsx";
import HaloButton from "./HaloButton.jsx";/**
 * HeroSection — version clean & compilable
 * - Parallax doux autour de la section
 * - Reveal subtil sur le H1
 * - CTA Halo
 * - Aucun tag mal fermé
 */
export default function HeroSection() {
  return (
    <LuxeParallax strength={0.18} className="hero-bg hero-bg relative">
      <section className="hero-bg hero-bg min-h-[80vh] grid place-items-center text-center px-6 py-20 bg-gradient-to-b from-black via-black/80 to-black text-neutral-100">
        <div className="max-w-4xl mx-auto space-y-6">
          <RevealOnScroll>
            <h1 className="mt-4 text-white/80">
              Le Luxe à la portée de tous... Pour des expériences inoubliables!
            </h1>
          </RevealOnScroll>          <p className="text-base md:text-lg text-neutral-300">
            Événements haut de gamme, élégants et mémorables. Luxe, Excellence, Innovation.
          </p>          <div className="flex items-center justify-center gap-3">
            <div className="mt-6 flex flex-wrap items-center gap-3"><HaloButton as="a" href="/devis" className="px-5 py-3 rounded-lg font-semibold text-black bg-yellow-400">Demander un devis</HaloButton>
  <a href="/realisations" className="cta-ghost ml-3">Voir nos réalisations</a></div>
            <a href="#services" className="sr-only text-sm text-neutral-300 hover:text-yellow-300 underline underline-offset-4">
              Découvrir nos services
            </a>
          </div>
        </div>
      </section>
    </LuxeParallax>
  );
}
