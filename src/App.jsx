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
