#!/bin/bash

echo "📦 Installation de lottie-react..."
npm install lottie-react

echo "✨ Création de LottieLoader.jsx..."
mkdir -p src/components

cat << 'COMPONENT' > src/components/LottieLoader.jsx
import React, { useEffect, useState } from "react";
import Lottie from "lottie-react";
import animationData from "@/assets/luxeevents-intro.json"; // Remplace par ton vrai fichier

export default function LottieLoader({ onFinish }) {
  const [played, setPlayed] = useState(false);

  useEffect(() => {
    const alreadyPlayed = sessionStorage.getItem("introPlayed");
    if (!alreadyPlayed) {
      setPlayed(true);
      setTimeout(() => {
        sessionStorage.setItem("introPlayed", "true");
        onFinish();
      }, 3000);
    } else {
      onFinish();
    }
  }, [onFinish]);

  if (!played) return null;

  return (
    <div className="fixed inset-0 z-50 bg-black flex items-center justify-center">
      <Lottie animationData={animationData} loop={false} className="w-64 h-64" />
    </div>
  );
}
COMPONENT

echo "🌀 Création de FadeUpWrapper.jsx..."
cat << 'COMPONENT' > src/components/FadeUpWrapper.jsx
import { motion } from "framer-motion";

export default function FadeUpWrapper({ children, delay = 0 }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.8, delay }}
      viewport={{ once: true }}
    >
      {children}
    </motion.div>
  );
}
COMPONENT

echo "🔁 Mise à jour de App.jsx pour Lottie..."
sed -i '1i import React, { useState } from "react";' src/App.jsx
sed -i '/import { Routes.*/a import LottieLoader from "@/components/LottieLoader";' src/App.jsx

sed -i 's/export default function App() {/export default function App() {\n  const [loaded, setLoaded] = useState(false);\n  const location = useLocation();\n\n  if (!loaded) return <LottieLoader onFinish={() => setLoaded(true)} \/>;/' src/App.jsx

echo "✅ Lottie intro et scroll reveal prêts à l'emploi ! Tu peux commit et deploy."
