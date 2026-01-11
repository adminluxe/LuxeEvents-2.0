import React from "react";
import servicesDefault, { services as servicesNamed } from "../data/services.luxe.js";
import PrimaryCTA, { DEVIS_ROUTE } from "./PrimaryCTA";


export default function ServicesSection() {
  const services = (servicesNamed && servicesNamed.length ? servicesNamed : servicesDefault) || [];

  return (
    <section id="services" className="relative py-20 sm:py-24">
      {/* Section backdrop */}
      <div
        className="absolute inset-0 -z-10 bg-gradient-to-b from-black/0 via-black/10 to-black/0"
        aria-hidden="true"
      />

      <div className="mx-auto max-w-6xl px-5 sm:px-8">
        <div className="flex items-end justify-between gap-6">
          <div>
            <div className="inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/5 px-4 py-2 text-[12px] tracking-wide text-white/80 backdrop-blur">
              <span className="text-[#D4AF37]">✦</span> Nos Services
            </div>
            <h2 className="mt-5 text-3xl sm:text-4xl font-[500] text-white">
              Une exécution premium, une signature LuxeEvents.
            </h2>
            <p className="mt-3 text-white/70 max-w-2xl">
              De la conception à la coordination, chaque détail est pensé pour un rendu
              élégant, fluide et mémorable.
            </p>
          </div>
        </div>

        {/* Grid */}
        <div className="mt-10 grid gap-4 sm:gap-5 md:grid-cols-2 lg:grid-cols-3">
          {services.map((s) => (
            <article
              key={s.id || s.title}
              className="group relative overflow-hidden rounded-2xl border border-white/10 bg-white/[0.04] backdrop-blur-md p-6 hover:bg-white/[0.06] transition"
            >
              {/* top glow line */}
              <div
                className="absolute inset-x-0 top-0 h-[2px] opacity-70 group-hover:opacity-100 transition"
                style={{
                  background:
                    "linear-gradient(90deg, rgba(212,175,55,0.0), rgba(212,175,55,0.9), rgba(212,175,55,0.0))",
                }}
                aria-hidden="true"
              />

              {/* subtle corner glow */}
              <div
                className="pointer-events-none absolute -top-20 -right-20 h-56 w-56 rounded-full blur-3xl opacity-0 group-hover:opacity-70 transition"
                style={{
                  background:
                    "radial-gradient(circle at center, rgba(212,175,55,0.25), transparent 60%)",
                }}
                aria-hidden="true"
              />

              <div className="flex items-start justify-between gap-4">
                <h3 className="text-lg font-[500] text-white">
                  <span className="text-[#D4AF37] mr-1">✦</span>
                  {s.title}
                </h3>
                {s.badge ? (
                  <span className="shrink-0 rounded-full border border-white/10 bg-black/30 px-3 py-1 text-[11px] text-white/75">
                    {s.badge}
                  </span>
                ) : null}
              </div>

              <p className="mt-3 text-sm leading-relaxed text-white/70">
                {s.description}
              </p>

              <div className="mt-5 flex items-center justify-between text-xs text-white/45">
                <span className="opacity-70">Service premium</span>
                <span className="opacity-0 group-hover:opacity-100 transition">→</span>
              </div>
            </article>
          ))}
        </div>

        {/* Mobile CTA (single source of truth) */}
        <div className="mt-10 sm:hidden">
          <PrimaryCTA to={DEVIS_ROUTE} label="Demander un devis" variant="mobile" />
        </div>
      </div>
    </section>
  );
}
