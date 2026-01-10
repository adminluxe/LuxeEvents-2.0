#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

TS="$(date +%Y%m%d-%H%M%S)"
BK="_backup_pimp_phase2_${TS}"
mkdir -p "$BK"

echo "🔎 Recherche du fichier Home qui rend <ServicesSection /> ..."
HOME_FILE="$(grep -RIl --exclude-dir=node_modules --exclude-dir=dist "<ServicesSection" src | head -n 1 || true)"

if [ -z "${HOME_FILE}" ]; then
  echo "❌ Impossible de trouver où <ServicesSection /> est utilisé."
  echo "👉 Lance: grep -RIn \"<ServicesSection\" src | head"
  exit 1
fi

echo "✅ Home détectée: $HOME_FILE"
cp -v "$HOME_FILE" "$BK/$(basename "$HOME_FILE").bak"

mkdir -p src/components

echo "✨ Création TrustSection.jsx"
cat > src/components/TrustSection.jsx <<'TRUST'
import React from "react";

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
            href="/devis"
            className="inline-flex items-center justify-center rounded-full px-6 py-3 text-sm font-medium text-black bg-[#D4AF37] hover:opacity-95 transition"
          >
            Obtenir une proposition sur-mesure →
          </a>
        </div>
      </div>
    </section>
  );
}
TRUST

echo "✨ Création GallerySection.jsx (réalisations teaser)"
cat > src/components/GallerySection.jsx <<'GALLERY'
import React from "react";

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
            href="/devis"
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
            href="/devis"
            className="inline-flex w-full items-center justify-center rounded-full px-6 py-3 text-sm font-medium text-black bg-[#D4AF37]"
          >
            Demander un devis →
          </a>
        </div>
      </div>
    </section>
  );
}
GALLERY

echo "🧩 Injection dans Home (après ServicesSection)"
# On injecte les imports si absents
if ! grep -q 'TrustSection' "$HOME_FILE"; then
  # ajoute imports sous les imports existants (première ligne après les imports)
  awk '
    BEGIN{done=0}
    /^import /{print; next}
    done==0{
      print "import TrustSection from \"../components/TrustSection.jsx\";";
      print "import GallerySection from \"../components/GallerySection.jsx\";";
      done=1
    }
    {print}
  ' "$HOME_FILE" > "$HOME_FILE.tmp" && mv "$HOME_FILE.tmp" "$HOME_FILE"
fi

# Insert JSX right after <ServicesSection ... />
if ! grep -q '<TrustSection' "$HOME_FILE"; then
  perl -0777 -i -pe 's|(<ServicesSection[^>]*\/>\s*)|\1\n      <TrustSection />\n      <GallerySection />\n|s' "$HOME_FILE"
fi

echo "✅ Phase 2 injectée dans: $HOME_FILE"
echo "➡️ Next: pnpm build && vercel --prod --force --yes"
