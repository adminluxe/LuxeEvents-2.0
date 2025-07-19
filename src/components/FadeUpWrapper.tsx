import { motion } from "framer-motion";

export default function FadeUpWrapper({ children }: { children: React.ReactNode }) {
  return (
    <motion.div initial={{ opacity: 0, y: 30 }} whileInView={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }}>
      {children}
    </motion.div>
  );
}
