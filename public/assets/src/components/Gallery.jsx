import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'

/**
 * On importe tous les visuels depuis /assets/images (pas /public/…)
 */
const images = import.meta.glob(
  '/assets/images/*.{png,jpg,jpeg,webp}',
  { eager: true, as: 'url' }
)

const photoList = Object.values(images)

export default function Gallery() {
  const [lightbox, setLightbox] = useState(null)

  return (
    <section className="py-16 px-4 bg-gray-50">
      <h2 className="text-3xl font-serif text-center mb-8">Galerie</h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        {photoList.map((src, i) => (
          <motion.img
            key={i}
            src={src}
            onClick={() => setLightbox(src)}
            className="cursor-pointer w-full h-60 object-cover rounded shadow-lg"
            whileHover={{ scale: 1.05 }}
            transition={{ type: 'spring', stiffness: 300 }}
          />
        ))}
      </div>

      <AnimatePresence>
        {lightbox && (
          <motion.div
            key="lightbox"
            className="fixed inset-0 bg-black/90 flex items-center justify-center z-50"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => setLightbox(null)}
          >
            <motion.img
              src={lightbox}
              className="max-h-[90%] max-w-[90%] rounded-lg shadow-2xl"
              initial={{ scale: 0.8 }}
              animate={{ scale: 1 }}
              exit={{ scale: 0.8 }}
            />
          </motion.div>
        )}
      </AnimatePresence>
    </section>
  )
}
