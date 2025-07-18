import React from "react";
import { motion } from "framer-motion";

export default function HeroSection() {
  return (
    <section
      id="hero"
      className="h-screen w-full flex flex-col justify-center items-center text-center text-white px-6 relative bg-cover bg-center"
      style={{ backgroundImage: "url('/media/images/luxeevents-bg-hero.webp')" }}
    >
      <div className="absolute inset-0 bg-black/50 z-0" />
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 1 }}
        className="relative z-10"
      >
        <h1 className="text-5xl md:text-6xl font-bold text-[#d4af37] mb-4 drop-shadow-lg">
          LuxeEvents
        </h1>
        <p className="text-lg md:text-xl text-white/90 max-w-xl mx-auto">
          Le luxe, à la portée de tous. Sublimez vos événements avec une touche d’élégance inoubliable.
        </p>
        <div className="mt-8 flex flex-col sm:flex-row gap-4 justify-center">
          <a href="#quote" className="bg-[#d4af37] text-black px-6 py-3 rounded-lg hover:bg-yellow-500 transition">
            Demander un devis
          </a>
          <a href="#services" className="border border-[#d4af37] px-6 py-3 rounded-lg hover:bg-[#d4af37] hover:text-black transition">
            Voir nos services
          </a>
        </div>
      </motion.div>
    </section>
  );
}
