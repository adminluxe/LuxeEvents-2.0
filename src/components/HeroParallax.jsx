import React from 'react';
import { Parallax } from 'react-parallax';

export default function HeroParallax() {
  return (
    <Parallax bgImage="/assets/hero-bg.jpg" strength={300}>
      <div className="h-screen flex items-center justify-center">
        <h1 className="text-7xl font-bold text-ivory drop-shadow-lg">Votre rêve, notre scène</h1>
      </div>
    </Parallax>
  );
}
