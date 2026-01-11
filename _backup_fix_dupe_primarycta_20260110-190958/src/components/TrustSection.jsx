import React from "react";
import PrimaryCTA, { DEVIS_ROUTE } from "./PrimaryCTA";


const stats = [
  { k: "120+", v: "Clients & invités satisfaits" },
  { k: "10 ans", v: "Expérience événementielle" },
  { k: "24/7", v: "Coordination & support" },
];

const proofs = [
  "Coordination Jour J sans stress",
  "Prestataires premium & sélectionnés",
  "Scénographie élégante & cohérente",
  "Exécution millimétrée",
];

export default function TrustSection() {
  return (
    <section id="confiance" className="relative py-20 sm:py-24">
      <div className="absolute inset-0 -z-10 bg-gradient-to-b from-black/0 via-black/10 to-black/0" aria-hidden="true" />

      <div className="mx-auto max-w-6xl px-5 sm:px-8">
        <div className="flex flex-col lg:flex-row lg:items-end lg:justify-between gap-8">
          <div className="max-w-2xl">
            <div className="inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/5 px-4 py-2 text-[12px] tracking-wide text-white/80 backdrop-blur">
              <span className="text-[#D4AF37]">✦</span> Ils nous font confiance
            </div>
            <h2 className="mt-5 text-3xl sm:text-4xl font-[500] text-white">
              La preuve par le détail.
            </h2>
            <p className="mt-3 text-white/70 leading-relaxed">
              LuxeEvents, c’est une équipe qui pilote, anticipe et sublime — pour une expérience fluide,
              premium et mémorable.
            </p>

            <div className="mt-6 flex flex-wrap gap-2">
              {proofs.map((t) => (
                <span
                  key={t}
                  className="rounded-full border border-white/10 bg-black/25 px-3 py-1.5 text-[12px] text-white/70 backdrop-blur"
                >
                  ✦ {t}
                </span>
              ))}
            </div>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 w-full lg:max-w-xl">
            {stats.map((s) => (
              <div
                key={s.k}
                className="relative overflow-hidden rounded-2xl border border-white/10 bg-white/[0.04] backdrop-blur p-5"
              >
                <div
                  className="absolute inset-x-0 top-0 h-[2px]"
                  style={{
                    background:
                      "linear-gradient(90deg, rgba(212,175,55,0.0), rgba(212,175,55,0.9), rgba(212,175,55,0.0))",
                    opacity: 0.7,
                  }}
                  aria-hidden="true"
                />
                <div className="text-2xl font-[600] text-white">{s.k}</div>
                <div className="mt-1 text-sm text-white/60">{s.v}</div>
              </div>
            ))}
          </div>
        </div>

        {/* CTA */}
        <div className="mt-10">
          <a
            href={DEVIS_ROUTE}
            className="inline-flex items-center justify-center rounded-full px-6 py-3 text-sm font-medium text-black bg-[#D4AF37] hover:opacity-95 transition"
          >
            Obtenir une proposition sur-mesure →
          </a>
        </div>
      </div>
    </section>
  );
}
