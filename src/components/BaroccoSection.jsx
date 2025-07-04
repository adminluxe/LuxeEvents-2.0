import React from "react";
import { motion } from "framer-motion";
import { useScrollAnim } from "../hooks/useScrollAnim";

export default function BaroccoSection() {
  const ref = useScrollAnim(el => el.classList.add("animate-pulse"), { threshold: 0.3 });
  return (
    <motion.section
      ref={ref}
      className="py-20 bg-gradient-to-r from-ivory to-gold"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.6 }}
    >
      <h2 className="text-4xl font-semibold text-center mb-6">Section Barocco</h2>
      <p className="max-w-2xl mx-auto text-center">Ton contenu sublime ici…</p>
    </motion.section>
  );
}
