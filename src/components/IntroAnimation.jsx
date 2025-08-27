import { useEffect, useState } from "react";
import Lottie from "lottie-react";
import animationData from "@/assets/luxeevents-intro.json";
import { motion, AnimatePresence } from "framer-motion";

export default function IntroAnimation({ onFinish }) {
  const [isVisible, setIsVisible] = useState(true);

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsVisible(false);
      if (onFinish) onFinish();
    }, 4000); // Durée de l’animation (ajuste si nécessaire)
    return () => clearTimeout(timer);
  }, [onFinish]);

  return (
    <AnimatePresence>
      {isVisible && (
        <motion.div
          className="fixed inset-0 z-50 bg-black flex items-center justify-center"
          initial={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 1 }}
        >
          <Lottie
            animationData={animationData}
            loop={false}
            className="w-80 h-80 sm:w-96 sm:h-96"
          />
        </motion.div>
      )}
    </AnimatePresence>
  );
}
