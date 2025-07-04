/*
  components/PatternSlider.jsx
  -----------------------------
  Slider Barocco-Interactive: un carrousel de motifs Versace en cinemagraphs.
  Utilise Swiper.js pour le slider et Framer Motion pour l'effet hover.

  Prérequis:
    npm install swiper framer-motion
    # inclure les styles de Swiper
    import 'swiper/css';

  Usage:
    import PatternSlider from './components/PatternSlider'
    <PatternSlider patterns={[
      { src: '/assets/patterns/barocco1.mp4', quote: '...'},
      ...
    ]} />

  Le composant:
    • Slider full-width, chaque slide autoplay vidéo en mute loop
    • Au hover, zoom léger et apparition de la citation
*/

import React from 'react'
import { motion } from 'framer-motion'
import { Swiper, SwiperSlide } from 'swiper/react'
import 'swiper/css'

export default function PatternSlider({ patterns }) {
  return (
    <Swiper
      spaceBetween={20}
      slidesPerView={1}
      loop
      autoplay={{ delay: 3000, disableOnInteraction: false }}
    >
      {patterns.map((p, i) => (
        <SwiperSlide key={i}>
          <div className="relative overflow-hidden rounded-xl">
            <motion.video
              src={p.src}
              autoPlay
              muted
              loop
              className="w-full h-auto object-cover"
              whileHover={{ scale: 1.05 }}
            />
            <motion.div
              className="absolute bottom-4 left-4 bg-black bg-opacity-50 text-white p-2 rounded"
              initial={{ opacity: 0, y: 20 }}
              whileHover={{ opacity: 1, y: 0 }}
            >
              {p.quote}
            </motion.div>
          </div>
        </SwiperSlide>
      ))}
    </Swiper>
  )
}
