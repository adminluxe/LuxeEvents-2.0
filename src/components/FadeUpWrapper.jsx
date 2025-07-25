import React from 'react';
import { motion } from 'framer-motion';

export default function FadeUpWrapper({ children }) {
  return (
    <>
      <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">
        ✅ VISIBLE: FadeUpWrapper.jsx
      </div>
      <motion.section
        initial={{ opacity: 0, y: 20 }}
        whileInView={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.8, ease: 'easeOut' }}
        viewport={{ once: true }}
      >
        {children}
      </motion.section>
    </>
  );
}
