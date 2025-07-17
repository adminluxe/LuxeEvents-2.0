import { motion } from "framer-motion";

export default function EventsSection() {
  return (
    <section className="min-h-screen py-20 px-4 bg-yellow-50 dark:bg-zinc-900 scroll-snap-start">
      <div className="max-w-4xl mx-auto text-center">
        <motion.h2
          initial={{ opacity: 0, scale: 0.8 }}
          whileInView={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.6 }}
          className="text-3xl font-bold text-zinc-800 dark:text-yellow-100 mb-4"
        >
          Événements
        </motion.h2>
        <p className="text-zinc-700 dark:text-zinc-300 text-lg">
          Mariages, soirées privées, lancements de produits… chaque événement devient un moment inoubliable.
        </p>
      </div>
    </section>
  );
}
