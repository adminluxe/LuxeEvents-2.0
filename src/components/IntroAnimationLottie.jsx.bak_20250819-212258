"use client";

import { useEffect, useState } from "react";
import Lottie from "lottie-react";
console.log("IntroAnimationLottie mounted");
console.log("introAnimation content:", introAnimation);
import introAnimation from "../assets/luxeevents-intro.json";

const IntroAnimationLottie = ({ onFinish }) => {
  const [visible, setVisible] = useState(() => {
    return !sessionStorage.getItem("introPlayed");
  });

  useEffect(() => {
    if (!visible) return;
    const timer = setTimeout(() => {
      sessionStorage.setItem("introPlayed", "true");
      setVisible(false);
      onFinish?.();
    }, 4000); // durée de l’animation

    return () => clearTimeout(timer);
  }, [visible, onFinish]);

  if (!visible) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black">
      <Lottie animationData={introAnimation} loop={false} className="w-64 h-64" />
    </div>
  );
};

export default IntroAnimationLottie;
