import { motion } from "framer-motion";
export default function CircularMenu(){
  return (
    <motion.div initial={{opacity:0,scale:.9}} animate={{opacity:1,scale:1}}
      className="fixed top-4 right-4 z-50 flex items-center gap-3 bg-black/40 backdrop-blur-md border border-amber-500 rounded-full px-3 py-2">
      <a href="https://instagram.com" target="_blank" rel="noreferrer" className="hover:scale-110 transition">📸</a>
      <a href="https://facebook.com"  target="_blank" rel="noreferrer" className="hover:scale-110 transition">📘</a>
      <a href="https://linkedin.com"  target="_blank" rel="noreferrer" className="hover:scale-110 transition">💼</a>
    </motion.div>
  );
}
