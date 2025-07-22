#!/bin/bash
echo "🚀 Injection App.jsx avec fallback timeout + fix..."

cat << 'JSX' > src/App.jsx
import React, { useState, useEffect } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import AudioAmbient from "./components/AudioAmbient";
import IntroAnimationLottie from "./components/IntroAnimationLottie";
import HeroSection from "./components/HeroSection";
import CircularMenu from "./components/CircularMenu";
import StorySwiper from "./components/StorySwiper";
import TimelineMagique from "./components/TimelineMagique";
import DevisPage from "./pages/devis"; // nouvelle page /devis

function HomePage() {
  return (
    <>
      <HeroSection />
      <StorySwiper />
      <TimelineMagique />
    </>
  );
}

function App() {
  const [introFinished, setIntroFinished] = useState(
    sessionStorage.getItem("introPlayed") === "true"
  );

  useEffect(() => {
    if (!introFinished) {
      const timeout = setTimeout(() => {
        console.warn("⏳ Timeout de fallback atteint. On passe à la suite.");
        setIntroFinished(true);
        sessionStorage.setItem("introPlayed", "true");
      }, 6000); // 6 sec fallback
      return () => clearTimeout(timeout);
    }
  }, [introFinished]);

  const handleIntroFinish = () => {
    console.log("✅ Animation intro terminée.");
    sessionStorage.setItem("introPlayed", "true");
    setIntroFinished(true);
  };

  return (
    <Router>
      {!introFinished && (
        <IntroAnimationLottie onFinish={handleIntroFinish} />
      )}
      {introFinished && (
        <>
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/devis" element={<DevisPage />} />
          </Routes>
          <CircularMenu />
          <AudioAmbient />
        </>
      )}
    </Router>
  );
}

export default App;
JSX

echo "✅ App.jsx corrigé injecté avec succès !"
