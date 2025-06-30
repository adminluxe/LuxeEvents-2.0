import { motion } from 'framer-motion';

export default function Hero() {
  return (
    <motion.section
      initial={{ opacity: 0, y: -50 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.8 }}
      className="relative h-screen flex items-center justify-center text-white overflow-hidden"
      style={{
        backgroundImage: 'linear-gradient(rgba(26,26,26,0.5), rgba(26,26,26,0.2)), url(/assets/hero.png)',
        backgroundSize: 'cover',
        backgroundPosition: 'center',
      }}
    >
      <motion.div
        initial={{ scale: 0.9 }}
        animate={{ scale: 1 }}
        transition={{ delay: 0.5, type: 'spring', stiffness: 60 }}
        className="relative z-10 text-center px-4"
      >
        <h1 className="text-5xl md:text-7xl font-serif mb-4 text-luxeGold">
          Osez l’Exception
        </h1>
        <p className="text-base md:text-lg max-w-2xl mx-auto mb-8 text-ivory-100">
          Offrez à vos invités une expérience inoubliable, où chaque détail respire le luxe.
        </p>
        <motion.button
          whileHover={{ scale: 1.05, boxShadow: '0 0 12px rgba(201,166,107,0.8)' }}
          className="bg-luxeGold text-luxeBlack py-3 px-8 rounded-full uppercase tracking-wide font-semibold"
        >
          Réservez votre événement
        </motion.button>
      </motion.div>
    </motion.section>
  );
}
