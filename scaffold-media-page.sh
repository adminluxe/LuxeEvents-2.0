#!/usr/bin/env bash
set -e

echo "📄 1. Création de src/pages/MediaPage.jsx…"
mkdir -p src/pages src/components
cat > src/pages/MediaPage.jsx << 'MP'
import React from 'react'
import Carousel from '../components/CarouselTestimonials'
export default function MediaPage() {
  return (
    <div className="pt-20 max-w-4xl mx-auto">
      <h2 className="text-3xl font-bold mb-6 text-center">Nos Réalisations</h2>
      <Carousel/>
    </div>
  )
}
MP

echo "🎠 2. Création de src/components/CarouselTestimonials.jsx…"
cat > src/components/CarouselTestimonials.jsx << 'CT'
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
    adaptiveHeight: true
  }
  return (
    <Slider {...settings}>
      {items.map((it, i) => (
        <div key={i} className="px-4">
          <img src={it.img} alt={it.caption} className="w-full h-64 object-cover rounded-lg" />
          <p className="mt-2 text-center text-gray-700">{it.caption}</p>
        </div>
      ))}
    </Slider>
  )
}
CT

echo "✅ MediaPage & Carousel prêts. N'oublie pas d'ajouter tes images dans public/media/…"
