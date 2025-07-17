import { motion } from "framer-motion";

export default function AboutSection() {
  return (
    <section className="min-h-screen py-20 px-4 bg-white dark:bg-zinc-800 scroll-snap-start">
      <div className="max-w-4xl mx-auto text-center">
        <motion.h2
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
          className="text-3xl font-bold text-zinc-900 dark:text-yellow-100 mb-4"
        >
          À propos
        </motion.h2>
        <p className="text-zinc-700 dark:text-zinc-300 text-lg">
          LuxeEvents est né d’un rêve : rendre le luxe événementiel accessible, élégant et magique.
        </p>
      </div>
    </section>
  );
}
