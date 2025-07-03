import { images } from '../data/mediaList'
import { motion } from 'framer-motion'

export default function Gallery() {
  return (
    <div className="grid grid-cols-3 gap-4">
      {images.map(src => (
        <motion.img
          key={src}
          src={src}
          alt="Événement Luxe"
          className="rounded-lg shadow-lg"
          whileHover={{ scale: 1.05 }}
        />
      ))}
    </div>
  )
}
