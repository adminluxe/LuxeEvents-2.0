import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Routes, useLocation } from 'react-router-dom';
import { AnimatePresence, motion } from 'framer-motion';

import IntroAnimationLottie from './components/IntroAnimationLottie';
import Footer from './components/Footer';
import CircularMenu from './components/CircularMenu';
import useSwipeNavigation from './hooks/useSwipeNavigation';
import CookieBanner from './components/CookieBanner';

import HomePage from './pages/HomePage';
import MediaPage from './pages/MediaPage';
import ServicesPage from './pages/ServicesPage';
import RequestQuotePage from './pages/RequestQuotePage';

export default function App() {
  const [introDone, setIntroDone] = useState(() => {
    return sessionStorage.getItem('introSeen') === 'true';
  });

  const location = useLocation();
  useSwipeNavigation();

  if (!introDone) {
    return (
      <IntroAnimationLottie
        onFinish={() => {
          sessionStorage.setItem('introSeen', 'true');
          setIntroDone(true);
        }}
      />
    );
  }

  return (
    <>
      <div className="fixed inset-0 -z-10 bg-no-repeat bg-cover bg-center opacity-20 dark:opacity-10" style={{ backgroundImage: "url(/media/background.png)" }}></div>

  <main className="scroll-snap-y overflow-y-scroll h-screen">
        <AnimatePresence mode="wait">
          <Routes location={location} key={location.pathname}>
            <Route
              path="/"
              element={
                <motion.div
                  initial={{ opacity: 0, rotateY: -90 }}
                  animate={{ opacity: 1, rotateY: 0 }}
                  exit={{ opacity: 0, rotateY: 90 }}
                  transition={{ duration: 0.6, ease: 'easeInOut' }}
                  className="min-h-screen"
                >
                  <HomePage />
                </motion.div>
              }
            />
            <Route
              path="/media"
              element={
                <motion.div
                  initial={{ opacity: 0, rotateY: -90 }}
                  animate={{ opacity: 1, rotateY: 0 }}
                  exit={{ opacity: 0, rotateY: 90 }}
                  transition={{ duration: 0.6, ease: 'easeInOut' }}
                  className="min-h-screen"
                >
                  <MediaPage />
                </motion.div>
              }
            />
            <Route
              path="/services"
              element={
                <motion.div
                  initial={{ opacity: 0, rotateY: -90 }}
                  animate={{ opacity: 1, rotateY: 0 }}
                  exit={{ opacity: 0, rotateY: 90 }}
                  transition={{ duration: 0.6, ease: 'easeInOut' }}
                  className="min-h-screen"
                >
                  <ServicesPage />
                </motion.div>
              }
            />
            <Route
              path="/demande-de-devis"
              element={
                <motion.div
                  initial={{ opacity: 0, rotateY: -90 }}
                  animate={{ opacity: 1, rotateY: 0 }}
                  exit={{ opacity: 0, rotateY: 90 }}
                  transition={{ duration: 0.6, ease: 'easeInOut' }}
                  className="min-h-screen"
                >
                  <RequestQuotePage />
                </motion.div>
              }
            />
          </Routes>
        </AnimatePresence>
      </main>
      <Footer />
      <CircularMenu />
      <CookieBanner />
    </>
  );
}
