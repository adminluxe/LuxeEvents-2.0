import { motion } from 'framer-motion';
import { CheckCircle } from 'lucide-react';

const features = [
  { title: 'Exclusivité', desc: 'Accès VIP, lieux secrets, prestations sur-mesure.' },
  { title: 'Émotion', desc: 'Ambiances uniques, scénographies immersives.' },
  { title: 'Innovation', desc: 'Tech & art fusionnés pour vivre l’inattendu.' },
];

export default function WhyChooseUs() {
  return (
    <section className="py-20 bg-luxeBlack text-white">
      <h2 className="text-4xl font-serif text-center mb-12">Pourquoi nous choisir ?</h2>
      <div className="max-w-4xl mx-auto grid gap-8 md:grid-cols-3 px-4">
        {features.map((f,i) => (
          <motion.div
            key={i}
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: i * 0.3 }}
            className="flex flex-col items-center text-center p-6 bg-gray-900/50 rounded-2xl shadow-xl"
          >
            <CheckCircle className="w-12 h-12 text-luxeGold mb-4" />
            <h3 className="text-2xl font-semibold mb-2">{f.title}</h3>
            <p className="text-sm">{f.desc}</p>
          </motion.div>
        ))}
      </div>
    </section>
  );
}
