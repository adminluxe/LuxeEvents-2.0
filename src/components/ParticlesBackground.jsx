import React from 'react';
import Particles from 'react-tsparticles';

export default function ParticlesBackground() {
  return (
    <Particles options={{
      fpsLimit: 60,
      interactivity: { events: { onHover: { enable: true, mode: "grab" }}},
      particles: {
        number: { value: 30 },
        color: { value: "#D4AF37" },
        links: { color: "#D4AF37", distance: 150, enable: true },
        move: { speed: 1 },
        opacity: { value: 0.7 }
      },
      detectRetina: true,
    }}/>
  );
}
