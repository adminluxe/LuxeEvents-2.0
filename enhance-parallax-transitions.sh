#!/bin/bash
echo "🌀 Ajout des effets Parallax + Transitions 3D entre pages..."

# 1. Ajout ParallaxWrapper.jsx
mkdir -p src/components

cat > src/components/ParallaxWrapper.jsx << 'EOF'
import { useEffect, useState } from "react";

export default function ParallaxWrapper({ children }) {
  const [offsetY, setOffsetY] = useState(0);

  useEffect(() => {
    const handleScroll = () => setOffsetY(window.scrollY);
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <div
      className="fixed top-0 left-0 w-full h-full -z-10 bg-cover bg-center transition-transform duration-300 ease-out"
      style={{
        backgroundImage: "url('/images/hero.jpg')",
        transform: `translateY(${offsetY * 0.3}px)`,
        backgroundAttachment: "scroll",
      }}
    />
  );
}
EOF

# 2. Mise à jour App.jsx avec AnimatePresence pour transition 3D
cat > src/App.jsx << 'EOF'
import { Routes, Route, useLocation } from "react-router-dom";
import { AnimatePresence, motion } from "framer-motion";
import HomePage from "@/pages/HomePage";
import ParallaxWrapper from "@/components/ParallaxWrapper";

export default function App() {
  const location = useLocation();

  return (
    <>
      <ParallaxWrapper />
      <AnimatePresence mode="wait">
        <Routes location={location} key={location.pathname}>
          <Route
            path="/"
            element={
              <motion.div
                initial={{ opacity: 0, rotateY: -15 }}
                animate={{ opacity: 1, rotateY: 0 }}
                exit={{ opacity: 0, rotateY: 15 }}
                transition={{ duration: 0.6 }}
              >
                <HomePage />
              </motion.div>
            }
          />
        </Routes>
      </AnimatePresence>
    </>
  );
}
EOF

# 3. Commit Git
git add src/components/ParallaxWrapper.jsx src/App.jsx
git commit -m "🌌 Ajout effet Parallax de fond + transitions 3D entre pages (Framer Motion)"

echo "✅ Effets immersifs appliqués avec succès."
