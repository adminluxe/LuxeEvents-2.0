"use client";

import { motion } from "framer-motion";

const events = [
  { year: "2020", text: "Naissance du rêve LuxeEvents" },
  { year: "2021", text: "Développement de la vision immersive" },
  { year: "2022", text: "Création des premiers événements privés" },
  { year: "2023", text: "Lancement de la plateforme numérique" },
  { year: "2024", text: "Expansion dans les capitales européennes" },
  { year: "2025", text: "Réalité augmentée & navigation next-gen" },
];

export default function TimelineMagique() {
  return (
    <section id="timeline" className="py-24 px-4 bg-black text-white">
      <div className="max-w-4xl mx-auto">
        <h2 className="text-3xl md:text-5xl font-bold text-gold mb-16 text-center">
          Notre Histoire
        </h2>
        <div className="relative border-l border-gold pl-6 space-y-12">
          {events.map((e, i) => (
            <motion.div
              key={i}
              initial={{ opacity: 0, x: -50 }}
              whileInView={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.5, delay: i * 0.2 }}
              viewport={{ once: true }}
              className="relative"
            >
              <div className="absolute -left-[14px] top-0 w-6 h-6 rounded-full bg-gold shadow-lg"></div>
              <h3 className="text-xl font-semibold text-gold">{e.year}</h3>
              <p className="text-white/80">{e.text}</p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
