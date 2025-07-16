import { motion } from "framer-motion";

export default function RevealSection() {
  return (
    <section className="h-screen snap-start bg-white flex flex-col md:flex-row items-center justify-center p-8">
      {/* Image */}
      <motion.img
        src="/images/luxeevents-story.jpg"
        alt="LuxeEvents Reveal"
        initial={{ x: -100, opacity: 0 }}
        whileInView={{ x: 0, opacity: 1 }}
        transition={{ duration: 1 }}
        className="w-full md:w-1/2 rounded-2xl shadow-xl object-cover"
      />

      {/* Texte */}
      <motion.div
        className="mt-8 md:mt-0 md:ml-12 max-w-xl text-center md:text-center"
        initial={{ x: 100, opacity: 0 }}
        whileInView={{ x: 0, opacity: 1 }}
        transition={{ duration: 1, delay: 0.3 }}
      >
        <h2 className="text-3xl font-luxury text-yellow-600 mb-4">Une révélation immersive</h2>
        <p className="text-lg text-gray-800">
          Découvrez la magie derrière chaque événement : élégance, lumière, émotion.
          LuxeEvents ne se contente pas d’organiser, il révèle une nouvelle expérience du luxe.
        </p>
      </motion.div>
    </section>
  );
}
