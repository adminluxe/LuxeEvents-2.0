import { motion } from 'framer-motion';
export default function Card({ children }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 30 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.6 }}
      whileHover={{ scale: 1.03, boxShadow: '0 0 15px var(--color-primary)' }}
    >
      {children}
    </motion.div>
  );
}
