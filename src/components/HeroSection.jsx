import React from "react";
import PrimaryCTA, { DEVIS_ROUTE } from "./PrimaryCTA";


export default function HeroSection() {
  return (
    <section
      id="top"
      className="relative isolate overflow-hidden min-h-[92vh] flex items-center"
    >

      {/* Background image */}
      
      <div
        className="absolute inset-0 -z-20 bg-center bg-cover"
        style={{ backgroundImage: "url(/images/hero/hero-bg.webp)" }}
        aria-hidden="true"
      />
      {/* Luxe overlays (clean, single pass) */}
      <div className="absolute inset-0 -z-10 bg-black/55" aria-hidden="true" />
      <div className="absolute inset-0 -z-10 bg-gradient-to-b from-black/40 via-black/55 to-black/75" aria-hidden="true" />
      <div className="absolute inset-0 -z-10 bg-[radial-gradient(circle_at_30%_20%,rgba(212,175,55,0.18),transparent_55%)]" aria-hidden="true" />

      {/* Soft gold glow */}
      <div className="pointer-events-none absolute inset-0 -z-10 opacity-80" aria-hidden="true">
        <div className="absolute -top-32 left-1/2 -translate-x-1/2 w-[900px] h-[900px] rounded-full blur-3xl bg-[radial-gradient(circle_at_center,rgba(212,175,55,0.26),transparent_60%)]" />
        <div className="absolute bottom-[-420px] right-[-220px] w-[900px] h-[900px] rounded-full blur-3xl bg-[radial-gradient(circle_at_center,rgba(255,255,255,0.08),transparent_60%)]" />
      </div>



      <div className="w-full px-5 sm:px-8">
        
<div className="mx-auto max-w-6xl">
          <div className="max-w-3xl">
            {/* Kicker */}
            <div className="inline-flex items-center gap-2 rounded-full border border-white/15 bg-white/5 px-4 py-2 text-[12px] sm:text-[13px] tracking-wide text-white/85 backdrop-blur">
              <span className="inline-block h-1.5 w-1.5 rounded-full bg-[#D4AF37]" />
              Événements haut de gamme • Belgique & Europe
            </div>

            {/* Headline */}
            <h1 className="mt-6 font-[500] leading-[1.05] text-white drop-shadow-[0_6px_22px_rgba(0,0,0,0.65)] text-4xl sm:text-5xl md:text-6xl">
              Le luxe à la portée de tous
              <span className="block mt-3 text-white/90 text-2xl sm:text-3xl md:text-4xl">
                Une expérience inoubliable.
              </span>
            </h1>

            <p className="mt-5 text-white/80 text-base sm:text-lg leading-relaxed max-w-2xl">
              Scénographie, coordination, prestataires premium, ambiance & détails
              millimétrés — on transforme ton événement en moment signature.
            </p>

            {/* CTAs */}
            <div className="mt-8 flex flex-col sm:flex-row items-stretch sm:items-center gap-3">
              <PrimaryCTA to={DEVIS_ROUTE} label="Demander un devis" variant="hero" />

              <a
                href="#services"
                className="inline-flex items-center justify-center rounded-full px-6 py-3 text-sm sm:text-base font-medium text-white border border-white/18 bg-white/5 hover:bg-white/10 backdrop-blur transition"
              >
                Découvrir nos services
              </a>
            </div>

            {/* Proof chips */}
            <div className="mt-10 flex flex-wrap gap-2">
              {[
                "Coordination Jour J",
                "Scénographie & design",
                "DJ / Live / Photo / Traiteur",
                "Expérience fluide & premium",
              ].map((t) => (
                <span
                  key={t}
                  className="rounded-full border border-white/12 bg-black/20 px-3 py-1.5 text-[12px] text-white/75 backdrop-blur"
                >
                  ✦ {t}
                </span>
              ))}
            </div>
          </div>
        </div>
      </div>

      {/* Bottom fade */}
      <div className="absolute bottom-0 left-0 right-0 h-28 bg-gradient-to-t from-black/90 to-transparent -z-10" />
    </section>
  );
}
