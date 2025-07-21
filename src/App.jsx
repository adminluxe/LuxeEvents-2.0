import React, { useState } from "react";
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

  return (
    <Router>
      {!introFinished && (
        <IntroAnimationLottie onFinish={() => setIntroFinished(true)} />
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
