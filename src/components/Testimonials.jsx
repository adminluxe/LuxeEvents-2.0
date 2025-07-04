import React from 'react'
import { motion } from 'framer-motion'

const quotes = [
  { text: '« LuxeEvents a transformé notre union en un conte de fées moderne… »', author: 'Isabelle & Marc' },
  { text: '« Leur sens du sur-mesure a sublimé notre gala corporate… »', author: 'Sophie L.' },
  { text: '« Un événement d’exception pensé dans les moindres recoins… »', author: 'Antoine R.' },
  { text: '« Dès le premier rendez-vous, on a su qu’on franchissait une nouvelle dimension… »', author: 'Élodie & Julien' },
]

export default function Testimonials() {
  return (
    <div className="max-w-4xl mx-auto space-y-12 px-6">
      {quotes.map((q, i) => (
        <motion.blockquote
          key={i}
          className="relative p-8 bg-noir text-ivory rounded-2xl shadow-2xl"
          initial={{ opacity: 0 }}
          whileInView={{ opacity: 1 }}
          viewport={{ once: true }}
          transition={{ delay: i * 0.3, duration: 0.8 }}
        >
          <p className="italic text-lg mb-4">{q.text}</p>
          <footer className="text-right font-sans uppercase tracking-wide">— {q.author}</footer>
        </motion.blockquote>
      ))}
    </div>
  )
}
