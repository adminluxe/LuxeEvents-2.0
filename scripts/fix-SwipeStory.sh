#!/bin/bash

FILE="src/components/SwipeStory.jsx"

echo "🛠 Correction finale de SwipeStory.jsx"

cat << 'EOL' > "$FILE"
import React from 'react';
import { Swiper, SwiperSlide } from 'swiper/react';
import 'swiper/css';

export default function SwipeStory() {
  const slides = [
    "Chaque événement est une œuvre d’art.",
    "Laissez-vous porter par l’élégance.",
    "LuxeEvents, bien plus qu’une agence.",
  ];

  return (
    <>
      <section className="py-20 bg-black text-white text-center">
        <Swiper spaceBetween={30} slidesPerView={1} loop>
          {slides.map((text, index) => (
            <SwiperSlide key={index}>
              <h3 className="text-xl md:text-3xl font-semibold">{text}</h3>
            </SwiperSlide>
          ))}
        </Swiper>
      </section>
    </>
  );
}
EOL

echo "✅ SwipeStory réparé et refermé proprement."
echo "🔁 Rebuild final + déploiement imminent..."
npm run build && vercel --prod --force --yes
