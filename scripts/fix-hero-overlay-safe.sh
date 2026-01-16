#!/bin/bash
set -euo pipefail

FILE="src/components/HeroSection.jsx"

echo "🧹 1) Suppression overlay mal injecté (si présent)..."
# On supprime la ligne exacte (même si elle a été injectée plusieurs fois)
sed -i '\|<div className="absolute inset-0 -z-10 bg-black/55 backdrop-blur-\[1px\]" />|d' "$FILE"

echo "🖼️ 2) Forcer le background image vers /images/hero/hero-bg.webp (si le pattern existe)..."
# Replace url(...) si on détecte une ancienne ref (luxeevents-bg-hero.webp ou autre)
# On vise la ligne backgroundImage: "url(...)" et on remplace seulement l'URL.
sed -i 's|backgroundImage: "url([^"]*)"|backgroundImage: "url(/images/hero/hero-bg.webp)"|g' "$FILE"

echo "🎨 3) Injection overlay au BON endroit : juste après le DIV background auto-fermé..."
# On injecte l'overlay juste après la ligne qui contient aria-hidden="true" suivie de />
# Ex: aria-hidden="true" ... puis ligne suivante "/>" (ou la même ligne)
# On fait simple : après la ligne contenant 'aria-hidden="true"' on insère, puis si le div n'est pas self-closing,
# l'overlay restera dans le bon bloc visuel.
grep -n 'aria-hidden="true"' "$FILE" >/dev/null 2>&1 || {
  echo "❌ Pattern aria-hidden=\"true\" introuvable dans $FILE. Abandon pour éviter dégâts."
  exit 1
}

# Injection après la ligne aria-hidden="true"
sed -i '/aria-hidden="true"/a\
      />\
      <div className="absolute inset-0 -z-10 bg-black/55 backdrop-blur-[1px]" aria-hidden="true" />\
      <div className="absolute inset-0 -z-10 bg-gradient-to-b from-black/40 via-black/55 to-black/70" aria-hidden="true" />\
      <div className="absolute inset-0 -z-10 bg-[radial-gradient(circle_at_30%_20%,rgba(212,175,55,0.18),transparent_55%)]" aria-hidden="true" />\
      <div' "$FILE"

echo "🧩 4) Réparer la balise <div ...> du background qui a été cassée par l'injection précédente..."
# L'injection précédente a probablement laissé un "<div" en trop (le début du bloc suivant).
# On corrige en supprimant la première occurrence de "      <div" juste après nos overlays si elle est orpheline.
# => On cherche la séquence: overlays + "      <div" qui suit immédiatement, et on enlève ce <div> en trop.
# (safe: ne modifie que ce cas précis)
perl -0777 -i -pe 's/(bg-\[radial-gradient[^\n]*\n\s*<div)\n\s*<div/\1/gm' "$FILE"

echo "✅ Fix appliqué."

echo "🔎 Aperçu des 40 premières lignes pour contrôle rapide :"
nl -ba "$FILE" | sed -n '1,80p'
