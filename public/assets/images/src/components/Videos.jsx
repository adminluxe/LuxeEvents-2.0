import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'

/**
 * On importe tous les .mp4 depuis /assets/videos
 */
const videos = import.meta.glob(
  '/assets/videos/*.{mp4,webm}',
  { eager: true, as: 'url' }
)

const videoList = Object.values(videos)

export default function Videos() {
  const [current, setCurrent] = useState(null)

  return (
    <section className="py-16 px-4 bg-white">
      <h2 className="text-3xl font-serif text-center mb-8">Vidéos</h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        {videoList.map((src, i) => (
          <motion.div
            key={i}
            className="relative cursor-pointer overflow-hidden rounded shadow"
            whileHover={{ scale: 1.02 }}
            onClick={() => setCurrent(src)}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: i * 0.1 }}
          >
            <video
              src={src}
              className="w-full h-48 object-cover"
              muted
              loop
              playsInline
              onMouseEnter={e => e.currentTarget.play()}
              onMouseLeave={e => {
                e.currentTarget.pause()
                e.currentTarget.currentTime = 0
              }}
            />
          </motion.div>
        ))}
      </div>

      <AnimatePresence>
        {current && (
          <motion.div
            className="fixed inset-0 bg-black/90 flex items-center justify-center z-50"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => setCurrent(null)}
          >
            <video
              src={current}
              controls
              autoPlay
              className="max-h-[90%] max-w-[90%] rounded-lg shadow-2xl"
            />
          </motion.div>
        )}
      </AnimatePresence>
    </section>
  )
}
