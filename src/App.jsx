import React, { useState } from "react";
import { Routes, Route, useLocation } from "react-router-dom";
import LottieLoader from "@/components/LottieLoader";
import { AnimatePresence, motion } from "framer-motion";
import HomePage from "@/pages/HomePage";

export default function App() {
  const [loaded, setLoaded] = useState(false);
  const location = useLocation();

  if (!loaded) return <LottieLoader onFinish={() => setLoaded(true)} />;
  const location = useLocation();

  return (
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
  );
}
