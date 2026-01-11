import React from "react";

const items = [
  { title: "Mariage — Signature", desc: "Scénographie, orchestration, moment signature.", tag: "MARIAGE" },
  { title: "Gala — Corporate", desc: "Exécution millimétrée, prestige & rythme.", tag: "CORPORATE" },
  { title: "Anniversaire — Sur-mesure", desc: "Ambiance immersive, détail & émotion.", tag: "SUR-MESURE" },
  { title: "Lancement — Brand", desc: "Narration, mise en scène, effet “wow”.", tag: "BRAND" },
  { title: "Soirée privée — Luxe", desc: "Expérience fluide, premium, sans friction.", tag: "PRIVÉ" },
  { title: "Cérémonie — Élégance", desc: "Palette, lumière, matières, cohérence totale.", tag: "ÉLÉGANCE" },
];

export default function RealisationsSection() {
  return (
    <section id="realisations" className="relative py-20 scroll-mt-24">
      <div className="mx-auto w-[min(1100px,92vw)]">
        <div className="inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/5 px-4 py-2 text-sm text-white/80">
          <span className="text-[#d4af37]">✦</span> Nos Réalisations
        </div>

        <h2 className="mt-6 text-3xl md:text-5xl font-semibold tracking-tight text-white">
          Des instants qui deviennent <span className="text-[#d4af37]">signature</span>.
        </h2>
        <p className="mt-4 max-w-2xl text-white/70">
          Quelques aperçus (placeholders) — remplaçables par tes vraies photos/vidéos. L’important ici :
          une section réelle, ancrable, qui donne enfin “du jus” à l’onglet Réalisations.
        </p>

        <div className="mt-10 grid gap-6 md:grid-cols-2 lg:grid-cols-3">
          {items.map((it) => (
            <article
              key={it.title}
              className="group relative overflow-hidden rounded-2xl border border-white/10 bg-black/35 p-6 shadow-[0_15px_45px_rgba(0,0,0,0.55)]"
            >
              {/* faux visuel */}
              <div className="absolute inset-0 opacity-40">
                <div className="h-full w-full bg-[radial-gradient(circle_at_30%_20%,rgba(212,175,55,0.22),transparent_55%),radial-gradient(circle_at_80%_70%,rgba(255,255,255,0.10),transparent_55%)]" />
              </div>

              <div className="relative">
                <div className="flex items-center justify-between gap-3">
                  <h3 className="text-lg font-semibold text-white/90">{it.title}</h3>
                  <span className="rounded-full border border-white/10 bg-white/5 px-3 py-1 text-xs text-white/70">
                    {it.tag}
                  </span>
                </div>
                <p className="mt-3 text-sm text-white/70">{it.desc}</p>

                <div className="mt-5 h-[140px] rounded-xl border border-white/10 bg-white/5" />

                <button className="mt-5 inline-flex items-center gap-2 text-sm text-[#f5e7b7] hover:text-white transition">
                  Voir plus <span className="opacity-70 group-hover:opacity-100">→</span>
                </button>
              </div>
            </article>
          ))}
        </div>
      </div>
    </section>
  );
}
