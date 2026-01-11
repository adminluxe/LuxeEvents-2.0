import React from "react";
import PrimaryCTA, { DEVIS_ROUTE } from "./PrimaryCTA";


const items = [
  { title: "Mariage chic", subtitle: "Scénographie • Coordination • Détails" },
  { title: "Soirée corporate", subtitle: "Exécution • Prestataires • Image premium" },
  { title: "Anniversaire signature", subtitle: "Ambiance • DJ • Mise en scène" },
  { title: "Décoration & fleurs", subtitle: "Palette • Matières • Lumière" },
  { title: "Table premium", subtitle: "Art de la table • Cohérence • Wow" },
  { title: "Moment fort", subtitle: "Entrée • Surprise • Climax" },
];

export default function GallerySection() {
  return (
    <section id="realisations" className="relative py-20 sm:py-24">
      <div className="absolute inset-0 -z-10 bg-gradient-to-b from-black/0 via-black/10 to-black/0" aria-hidden="true" />

      <div className="mx-auto max-w-6xl px-5 sm:px-8">
        <div className="flex items-end justify-between gap-6">
          <div>
            <div className="inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/5 px-4 py-2 text-[12px] tracking-wide text-white/80 backdrop-blur">
              <span className="text-[#D4AF37]">✦</span> Réalisations
            </div>
            <h2 className="mt-5 text-3xl sm:text-4xl font-[500] text-white">
              Un aperçu de notre univers.
            </h2>
            <p className="mt-3 text-white/70 max-w-2xl">
              Une galerie “teaser” (sans images pour l’instant). Ensuite on branchera tes vrais visuels
              pour un rendu cinématique.
            </p>
          </div>

          <a
            href={DEVIS_ROUTE}
            className="hidden sm:inline-flex items-center justify-center rounded-full px-5 py-2.5 text-sm font-medium text-white border border-white/15 bg-white/5 hover:bg-white/10 backdrop-blur transition"
          >
            Parler de ton événement →
          </a>
        </div>

        <div className="mt-10 grid gap-4 sm:gap-5 md:grid-cols-2 lg:grid-cols-3">
          {items.map((it) => (
            <article
              key={it.title}
              className="group relative overflow-hidden rounded-2xl border border-white/10 bg-white/[0.035] backdrop-blur p-6 hover:bg-white/[0.055] transition"
            >
              <div
                className="absolute -top-24 -right-24 h-64 w-64 rounded-full blur-3xl opacity-0 group-hover:opacity-70 transition"
                style={{
                  background:
                    "radial-gradient(circle at center, rgba(212,175,55,0.20), transparent 60%)",
                }}
                aria-hidden="true"
              />
              <div className="text-white font-[500] text-lg">
                <span className="text-[#D4AF37] mr-1">✦</span>
                {it.title}
              </div>
              <div className="mt-2 text-sm text-white/65">{it.subtitle}</div>

              <div className="mt-6 h-[120px] rounded-xl border border-white/10 bg-gradient-to-br from-white/[0.06] to-black/10" />

              <div className="mt-5 flex items-center justify-between text-xs text-white/45">
                <span>Preview</span>
                <span className="opacity-0 group-hover:opacity-100 transition">→</span>
              </div>
            </article>
          ))}
        </div>

        <div className="mt-10 sm:hidden">
          <a
            href={DEVIS_ROUTE}
            className="inline-flex w-full items-center justify-center rounded-full px-6 py-3 text-sm font-medium text-black bg-[#D4AF37]"
          >
            Demander un devis →
          </a>
        </div>
      </div>
    </section>
  );
}
