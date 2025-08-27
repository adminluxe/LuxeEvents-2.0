// src/components/HeroSection.jsx
import { useState, useEffect, useRef } from "react";
import { motion, useScroll, useTransform } from "framer-motion";

export default function HeroSection() {
  const ref = useRef(null);
  const { scrollYProgress } = useScroll({ target: ref });
  const parallax = useTransform(scrollYProgress, [0, 1], [1, 0.6]);

  const [audioPlayed, setAudioPlayed] = useState(false);

  const playIntroSound = () => {
    const audio = new Audio("/audio/entry-sound.mp3");
    audio.volume = 0.7;
    audio.play();
    setAudioPlayed(true);
  };

  const playClickSound = () => {
    const audio = new Audio("/audio/luxury-click.mp3");
    audio.volume = 0.5;
    audio.play();
  };

  useEffect(() => {
    if (!audioPlayed) {
      document.getElementById("play-button").addEventListener("click", playIntroSound);
    }
  }, [audioPlayed]);

  return (
    <section className="relative h-screen w-full scroll-snap-start bg-black overflow-hidden text-white" ref={ref}>
      {/* Fond background.png */}
      <div
        className="absolute inset-0 -z-10 bg-cover bg-center opacity-20 dark:opacity-10"
        style={{ backgroundImage: "url(/media/background.png)" }}
      ></div>

      {/* Fond animé parallax */}
      <motion.div
        style={{ scale: parallax }}
        className="absolute inset-0 bg-gradient-to-br from-yellow-300 via-black to-white blur-2xl opacity-20"
      />

      {/* Contenu */}
      <div className="relative z-10 flex flex-col items-center justify-center h-full text-center px-4">
        <motion.h1
          initial={{ y: 60, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 1 }}
          className="text-4xl sm:text-6xl font-luxury tracking-widest text-yellow-400 drop-shadow-lg"
        >
          Le luxe à la portée de tous
        </motion.h1>

        <motion.p
          initial={{ y: 30, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 1.5 }}
          className="mt-6 max-w-2xl text-lg sm:text-xl text-ivory drop-shadow-md"
        >
          Événements sur-mesure, élégance inoubliable.
          Plongez dans une nouvelle ère de raffinement.
        </motion.p>

        {/* Bouton CTA avec halo + son */}
        <motion.button
          id="play-button"
          onClick={playClickSound}
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
          transition={{ type: "spring", stiffness: 300 }}
          className="relative mt-10 px-8 py-3 rounded-2xl text-white bg-yellow-500 hover:bg-yellow-400 font-semibold text-lg overflow-hidden"
        >
          <span className="relative z-10">Découvrir nos services</span>
          <span className="absolute inset-0 rounded-2xl bg-yellow-400 opacity-20 blur-xl animate-ping pointer-events-none" />
        </motion.button>
      </div>
    </section>
  );
}
