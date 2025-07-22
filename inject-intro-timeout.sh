#!/bin/bash
echo "🎬 Injection du fallback dans IntroAnimationLottie.jsx..."

cat << 'JSX' > src/components/IntroAnimationLottie.jsx
import React, { useEffect } from "react";
import Lottie from "lottie-react";
import animationData from "../assets/lottie/luxeevents-intro.json";

function IntroAnimationLottie({ onFinish }) {
  useEffect(() => {
    const timeout = setTimeout(() => {
      console.warn("⏳ Timeout 6s dépassé, on passe !");
      sessionStorage.setItem("introPlayed", "true");
      onFinish();
    }, 6000);

    const handler = () => {
      console.log("🔔 Event reçu : audio-ready");
      clearTimeout(timeout);
      sessionStorage.setItem("introPlayed", "true");
      onFinish();
    };

    window.addEventListener("audio-ready", handler);
    return () => {
      clearTimeout(timeout);
      window.removeEventListener("audio-ready", handler);
    };
  }, [onFinish]);

  return (
    <div className="flex items-center justify-center min-h-screen bg-black text-gold font-lux text-center flex-col gap-6">
      <div className="w-24 h-24 rounded-full bg-gold animate-pulse"></div>
      <p>Chargement de l’univers LuxeEvents...</p>
    </div>
  );
}

export default IntroAnimationLottie;
JSX

echo "✅ IntroAnimationLottie.jsx mis à jour avec timeout + fallback audio-ready"
