import { Link } from 'react-router-dom'
import { motion } from 'framer-motion'

export default function Header() {
  return (
    <motion.header
      initial={{ opacity: 0, y: -50 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 1 }}
      className="py-8 text-center text-luxeWhite"
    >
      <h1 className="text-5xl font-serif mb-4">Osez l’Exception</h1>
      <motion.div whileHover={{ scale: 1.05 }} whileTap={{ scale: 0.95 }}>
        <Link
          to="/reserver"
          className="bg-gold hover:bg-yellow text-luxeBlack font-bold py-3 px-6 rounded-full"
        >
          Réservez votre événement
        </Link>
      </motion.div>
    </motion.header>
  )
}
