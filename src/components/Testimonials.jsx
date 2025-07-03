import testimonials from '../data/testimonials'
import { motion } from 'framer-motion'

export default function Testimonials() {
  return (
    <div className="space-y-8">
      {testimonials.map((t, i) => (
        <motion.blockquote
          key={i}
          className="p-6 bg-white rounded-xl shadow-lg"
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
        >
          <p className="italic text-lg">“{t.text}”</p>
          <footer className="mt-4 text-right font-semibold">
            — {t.author}, <span className="text-sm text-gray-500">{t.role}</span>
          </footer>
        </motion.blockquote>
      ))}
    </div>
  )
}
