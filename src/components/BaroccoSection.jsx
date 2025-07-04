import React from 'react'
import { motion } from 'framer-motion'
import PatternSlider from './PatternSlider'

const patterns = [
  { src: '/assets/media/images/img-001.webp', quote: '« L’art de l’événement, réinventé à chaque instant. »' },
  { src: '/assets/media/images/img-002.webp', quote: '« Vos rêves deviennent spectacle. »' },
  { src: '/assets/media/images/img-003.webp', quote: '« Un univers sur-mesure, infiniment vôtre. »' },
]

export default function BaroccoSection() {
  return (
    <section id="barocco" className="py-20 bg-gradient-to-r from-ivory to-gold">
      <h2 className="text-5xl font-bold text-center text-noir mb-12">Parcours Haute Couture</h2>
      <motion.div
        className="max-w-4xl mx-auto"
        initial={{ opacity: 0, y: 40 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8 }}
      >
        <PatternSlider patterns={patterns} />
      </motion.div>
    </section>
  )
}
