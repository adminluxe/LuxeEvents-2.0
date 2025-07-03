#!/usr/bin/env bash
set -euo pipefail

# ────────────────────────────────────────────────────────────────────────────────
# 🏗️  setup-landing.sh — scaffold complet de la landing LuxeEvents
# ────────────────────────────────────────────────────────────────────────────────

echo "🚀 Starting landing setup…"

# 1) Nettoyage et renommage des fichiers non-ASCII dans public/
echo "1) Renommage des assets public/ (apostrophes, accents → tirets)…"
find public -type f \( -name "*’*" -o -name "*‘*" -o -name "*é*" -o -name "*à*" \) | \
  while read -r file; do
    clean=$(echo "$file" \
      | sed -E "s/[’‘]/-/g; s/[éèêë]/e/g; s/[àâä]/a/g; s/[^A-Za-z0-9._\/-]/-/g")
    echo "   • $file → $clean"
    mv "$file" "$clean"
  done

# 2) Copier / remplacer le hero.mp4 et hero.jpg placeholders
echo "2) Téléchargement des placeholders en local…"
curl -sfLo public/hero-loop.mp4 https://media.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.mp4 || true
curl -sfLo public/hero.jpg       https://via.placeholder.com/1920x1080           || true

# 3) Mettre à jour Hero.jsx pour utiliser la vidéo
echo "3) Patch Hero.jsx → video background…"
sed -i "/<img.*hero.jpg/ {
  s|<img.*|<video src=\"/hero-loop.mp4\" autoplay loop muted className=\"absolute inset-0 w-full h-full object-cover\" \/>|
}" src/components/landing/Hero.jsx

# 4) Compléter les descriptions sous chaque carte “piliers”
echo "4) Ajout du champ desc dans Landing.jsx…"
perl -i -pe '
  if(/const features =/) {
    $_ .= "  // desc ajouté automatiquement\n";
    $_ .= "  const features = [\n";
    $_ .= "    { title: \"Cocktails Signature\", img: \"/cocktail.jpg\", desc: \"Atelier sur-mesure pour vos papilles.\" },\n";
    $_ .= "    { title: \"Soirée Jazz\",          img: \"/jazz.jpg\",     desc: \"Ambiance feutrée et notes soul.\" },\n";
    $_ .= "    { title: \"Banquet Royal\",         img: \"/banquet.jpg\",  desc: \"Grandeur et raffinement absolus.\" },\n";
    $_ .= "  ];\n";
  }
' src/pages/Landing.jsx

# 5) Scaffold Testimonials.jsx + hook useTestimonials
echo "5) Création Testimonials.jsx et useTestimonials.js…"
cat > src/hooks/useTestimonials.js << 'EOF'
import { useState, useEffect } from 'react'
import axios from 'axios'
const API = import.meta.env.VITE_CMS_URL

export function useTestimonials() {
  const [testimonials, setTestimonials] = useState([])
  useEffect(() => {
    axios.get(\`\${API}/api/testimonials?populate=photo\`)
      .then(({ data }) => setTestimonials(data.data))
      .catch(console.error)
  }, [])
  return testimonials
}
EOF

cat > src/components/landing/Testimonials.jsx << 'EOF'
import React from 'react'
import { useTestimonials } from '../../hooks/useTestimonials'

export default function Testimonials() {
  const data = useTestimonials()
  return (
    <section className="py-16 bg-white">
      <h2 className="text-3xl text-center mb-8">Ils ont vécu l’Exception</h2>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8 px-4">
        {data.map(({ id, attributes }) => (
          <figure key={id} className="text-center">
            <img src={attributes.photo.data.attributes.url}
                 alt={attributes.name}
                 className="w-24 h-24 rounded-full mx-auto mb-4" />
            <blockquote className="italic">&ldquo;{attributes.quote}&rdquo;</blockquote>
            <figcaption className="mt-2 font-bold">{attributes.name}</figcaption>
            <small className="block text-gray-500">{attributes.role}</small>
          </figure>
        ))}
      </div>
    </section>
  )
}
EOF

# 6) Lien “Réservez maintenant” dans Hero.jsx
echo "6) Ajout du bouton Réservez maintenant…"
perl -i -0777 -pe '
  s#(<h1[^>]*>Offrez l’Exception</h1>)#\1\n      <button onClick={() => navigate("/reserver")} className="mt-6 bg-gold text-black px-6 py-3 rounded">Réservez maintenant</button>#s
' src/components/landing/Hero.jsx

# 7) Nettoyage cache Vite & npm modules
echo "7) Suppression du cache Vite & relance deps…"
rm -rf node_modules/.vite

# 8) Relance du serveur en mode host
echo "8) 🚀 Tout est prêt, lance :"
echo "    npm run dev -- --host"

echo "🎉 Landing setup terminé !"

exit 0
