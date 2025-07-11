import React from 'react';
import Lottie from 'react-lottie-player';
import animationData from '../media/logo.json';

export default function LogoAnimated() {
  return (
    <Lottie
      animationData={animationData}
      play
      loop
      style={{ width: 80, height: 80 }}
    />
  );
}
