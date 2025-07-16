import { motion } from "framer-motion";

export default function NextSection() {
  return (
    <section className="h-screen bg-white scroll-snap-start flex flex-col items-center justify-center text-center px-4">
      <motion.h2
        initial={{ y: 40, opacity: 0 }}
        whileInView={{ y: 0, opacity: 1 }}
        viewport={{ once: true }}
        transition={{ duration: 1 }}
        className="text-3xl sm:text-5xl font-bold text-yellow-600"
      >
        Une aventure sensorielle commence
      </motion.h2>
      <motion.p
        initial={{ y: 20, opacity: 0 }}
        whileInView={{ y: 0, opacity: 1 }}
        viewport={{ once: true }}
        transition={{ duration: 1.3 }}
        className="mt-4 max-w-xl text-lg text-gray-700"
      >
        Découvrez une nouvelle manière de vivre l’événementiel.
        Scroll, touchez, plongez dans l’univers LuxeEvents.
      </motion.p>
    </section>
  );
}
