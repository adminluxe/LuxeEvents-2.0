#!/bin/bash
set -euo pipefail

FILE="src/components/HeroSection.jsx"

echo "🧼 Nettoyage: remplacement bloc Background/Overlays par version clean..."

perl -0777 -i -pe 's{
(\s*\{\s*\/\*\s*Background\s+image\s*\*\/\s*\}\s*)
.*?
(\s*<div\s+className="w-full\s+px-5\s+sm:px-8">\s*)
}{
$1
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

$2
}gmsx' "$FILE"

echo "✅ Bloc clean appliqué."

echo "🔎 Vérif rapide: afficher la zone hero (lignes 1-90)"
nl -ba "$FILE" | sed -n '1,90p'
