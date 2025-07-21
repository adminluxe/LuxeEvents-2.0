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
