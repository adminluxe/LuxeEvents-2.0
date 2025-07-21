import { motion } from "framer-motion";

const items = [
  "Brief & imagination",
  "Design & storytelling",
  "Coordination & technique",
  "Réalisation & magie",
];

export default function Timeline() {
  return (
    <div className="max-w-3xl mx-auto">
      <h2 className="text-2xl font-semibold mb-6">Notre méthode</h2>
      <ul className="space-y-4">
        {items.map((step, index) => (
          <motion.li
            key={index}
            initial={{ opacity: 0, x: -30 }}
            whileInView={{ opacity: 1, x: 0 }}
            transition={{ delay: index * 0.2 }}
            className="p-4 border-l-4 border-yellow-300 bg-white/10 rounded-md"
          >
            {step}
          </motion.li>
        ))}
      </ul>
    </div>
  );
}
