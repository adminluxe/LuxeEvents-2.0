#!/usr/bin/env bash
set -e

MEDIA_PAGE="src/pages/MediaPage.jsx"
CAROUSEL_COMP="src/components/CarouselTestimonials.jsx"
MEDIA_DIR="public/media"
IMAGES=(event1.jpg event2.jpg event3.jpg)

echo "🚀 Scaffold MediaPage & Carousel"

# 1) Crée les répertoires si besoin
mkdir -p src/pages src/components "$MEDIA_DIR"

# 2) MediaPage.jsx
if [ ! -f "$MEDIA_PAGE" ]; then
  echo "📄 Création de $MEDIA_PAGE"
  cat > "$MEDIA_PAGE" << 'MP'
import React from 'react'
import Carousel from '../components/CarouselTestimonials'

export default function MediaPage() {
  return (
    <div className="pt-20 max-w-4xl mx-auto">
      <h2 className="text-3xl font-bold mb-6 text-center">Nos Réalisations</h2>
      <Carousel />
    </div>
  )
}
MP
else
  echo "ℹ $MEDIA_PAGE existe déjà, skip."
fi

# 3) CarouselTestimonials.jsx
if [ ! -f "$CAROUSEL_COMP" ]; then
  echo "🎠 Création de $CAROUSEL_COMP"
  cat > "$CAROUSEL_COMP" << 'CT'
import React from 'react'
import Slider from 'react-slick'
import 'slick-carousel/slick/slick.css'
import 'slick-carousel/slick/slick-theme.css'

const items = [
  { img: '/media/event1.jpg', caption: 'Mariage au Château' },
  { img: '/media/event2.jpg', caption: 'Gala d’entreprise' },
  { img: '/media/event3.jpg', caption: 'Soirée privée' },
]

export default function CarouselTestimonials() {
  const settings = {
    dots: true,
    infinite: true,
    speed: 500,
    slidesToShow: 1,
    slidesToScroll: 1,
    adaptiveHeight: true,
  }
  return (
    <Slider {...settings}>
      {items.map((it, i) => (
        <div key={i} className="px-4">
          <img
            src={it.img}
            alt={it.caption}
            className="w-full h-64 object-cover rounded-lg"
          />
          <p className="mt-2 text-center text-gray-700">{it.caption}</p>
        </div>
      ))}
    </Slider>
  )
}
CT
else
  echo "ℹ $CAROUSEL_COMP existe déjà, skip."
fi

# 4) Stub d’images
for IMG in "${IMAGES[@]}"; do
  TARGET="$MEDIA_DIR/$IMG"
  if [ ! -f "$TARGET" ]; then
    echo "🖼️  Ajout stub image $IMG"
    # un carré transparent de 800×400
    convert -size 800x400 xc:lightgray "$TARGET" 2>/dev/null || \
      { echo "   (Pas d'ImageMagick: crée manuellement $TARGET)"; }
  else
    echo "ℹ $TARGET existe déjà, skip."
  fi
done

echo "✅ Scaffold terminé."
echo "👉 Vérifie http://localhost:5173/media puis remplace les stub par tes vraies photos dans $MEDIA_DIR"
