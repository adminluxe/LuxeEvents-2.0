#!/usr/bin/env bash
set -e

echo "🗡️ Excalibur : lancement des enhancements final luxe…"

# 1) Tailwind : boxShadow sur-mesure
sed -i "/extend: {/a\      boxShadow: {\n        'lux-soft': '0 4px 14px rgba(0, 0, 0, 0.1)',\n        'lux-glow': '0 0 30px rgba(212, 175, 55, 0.6)',\n      }," tailwind.config.js

# 2) Boutons luxe + typewriter CSS
cat << 'EOF' >> src/index.css

@layer components {
  .btn-luxe {
    @apply inline-block px-6 py-3 bg-gold text-noir font-semibold uppercase rounded-full shadow-lux-soft transition transform;
  }
  .btn-luxe:hover {
    @apply scale-105 shadow-lux-glow;
  }
  .btn-luxe:active { @apply scale-95; }

  .typewriter {
    overflow: hidden; white-space: nowrap;
    border-right: 2px solid theme('colors.gold');
    animation: typing 4s steps(40) 1s forwards, blink 0.75s step-end infinite;
  }
}
@keyframes typing { from { width: 0 } to { width: 100% } }
@keyframes blink { 50% { border-color: transparent } }
EOF

# 3) Installation des dépendances visuelles
npm install react-parallax react-parallax-tilt react-tsparticles @tsparticles/react

# 4) Curseur personnalisé
cat << 'EOF' >> src/index.css

@layer base {
  body { cursor: url('/cursor-gold.cur'), auto; }
  a, button { cursor: url('/cursor-or.cur'), pointer; }
}
EOF

# 5) Hero Parallax
cat << 'EOF' > src/components/HeroParallax.jsx
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
EOF

# 5b) Gallery Tilt
sed -i "1i import Tilt from 'react-parallax-tilt';" src/components/Gallery.jsx
sed -i "/images.map/,+3d" src/components/Gallery.jsx
sed -i "/return (/a\\
        {images.map((src,i) => (  \\
          <Tilt key={i} glareEnable glareMaxOpacity={0.2} className=\"rounded-2xl overflow-hidden shadow-xl\">  \\
            <figure className=\"group relative\">  \\
              <img src={src} alt={\`Galerie \${i+1}\`} className=\"w-full h-64 object-cover transition-transform duration-700 group-hover:scale-105\" />  \\
            </figure>  \\
          </Tilt>  \\
        ))}" src/components/Gallery.jsx

# 6) Particules or
cat << 'EOF' > src/components/ParticlesBackground.jsx
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
EOF

# Inclure dans App.jsx
sed -i "1i import ParticlesBackground from './components/ParticlesBackground';" src/App.jsx
sed -i "/<div className=\"flex flex-col/ a\\
      <ParticlesBackground className=\"absolute inset-0 -z-10\" />" src/App.jsx

# 7) Preload critique CSS
sed -i "/<head>/a\\
  <link rel=\"preload\" href=\"/src/index.css\" as=\"style\">\\
  <link rel=\"stylesheet\" href=\"/src/index.css\">" index.html

# 8) Fix hook useScrollAnim
sed -i '1,2d' src/components/BaroccoSection.jsx
sed -i '1i import { useScrollAnim } from "../hooks/useScrollAnim";' src/components/BaroccoSection.jsx
sed -i "/<section id=\"barocco\"/c\<section id=\"barocco\" ref={useScrollAnim(el=>el.classList.add('animate-pulse'),{threshold:0.3})} className=\"py-20 bg-gradient-to-r from-ivory to-gold\">" src/components/BaroccoSection.jsx

echo "✅ Excalibur terminé ! Relance ton serveur : npm run dev"
