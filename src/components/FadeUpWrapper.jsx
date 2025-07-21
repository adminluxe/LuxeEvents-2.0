import { motion } from "framer-motion";

export default function FadeUpWrapper({ children, className = "" }) {
  return (
    <motion.section
      className={\`snap-start \${className}\`}
      initial={{ opacity: 0, y: 50 }}
      whileInView={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.6 }}
      viewport={{ once: true, amount: 0.5 }}
    >
      {children}
    </motion.section>
  );
}
