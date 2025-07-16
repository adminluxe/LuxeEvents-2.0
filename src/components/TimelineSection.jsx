import { motion } from "framer-motion";

const milestones = [
  {
    year: "2023",
    title: "Création de LuxeEvents",
    description: "Lancement officiel avec la volonté de bousculer les codes de l’événementiel.",
  },
  {
    year: "2024",
    title: "Immersion & Expérience",
    description: "Déploiement d’expériences numériques inédites sur la plateforme.",
  },
  {
    year: "2025",
    title: "Expansion & Vision",
    description: "Vers une présence internationale, en gardant l’élégance au cœur.",
  },
];

export default function TimelineSection() {
  return (
    <section className="bg-white text-black py-24 px-6 scroll-snap-start">
      <div className="max-w-4xl mx-auto">
        <h2 className="text-3xl sm:text-5xl font-bold text-center text-yellow-600 mb-16">
          Notre Timeline
        </h2>
        <div className="space-y-12">
          {milestones.map((step, index) => (
            <motion.div
              key={index}
              initial={{ opacity: 0, y: 60 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.7, delay: index * 0.2 }}
              className="bg-ivory rounded-xl shadow-lg p-6 border-l-4 border-yellow-500"
            >
              <h3 className="text-xl font-semibold text-yellow-600">{step.year} – {step.title}</h3>
              <p className="mt-2 text-gray-800">{step.description}</p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
