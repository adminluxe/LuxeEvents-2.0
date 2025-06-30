import { Link } from 'react-router-dom'
import { motion } from 'framer-motion'
export default function Hero() {
  return (
    <section className="relative h-screen overflow-hidden">
      <video src="/assets/hero-loop.mp4" className="absolute inset-0 w-full h-full object-cover" autoPlay loop muted playsInline/>
      <div className="absolute inset-0 bg-black/40"></div>
      <motion.div initial={{opacity:0,y:20}} animate={{opacity:1,y:0}} transition={{delay:0.5}} className="relative z-10 max-w-3xl mx-auto text-center text-luxeWhite p-4">
        <h1 className="text-5xl font-serif mb-4">Offrez l’Exception</h1>
        <p className="mb-6">Une expérience inoubliable où chaque détail respire le luxe.</p>
        <Link to="/reserver" className="bg-gold hover:bg-yellow text-luxeBlack font-bold py-3 px-6 rounded-full">Réservez maintenant</Link>
      </motion.div>
    </section>
  )
}
