#!/bin/bash

echo "🚀 Nova déploie LuxeEvents avec puissance..."

cd "$(dirname "$0")"
mkdir -p src/pages

# CSS
cat > src/pages/Gallery.css << 'EOF'
.gallery-container {
  max-width: 900px;
  margin: 3rem auto;
  padding: 0 1rem;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  color: #222;
}
.gallery-container h2 {
  text-align: center;
  margin-bottom: 2rem;
  font-weight: 700;
  letter-spacing: 0.05em;
  color: #4a148c;
}
.gallery-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 1.5rem;
}
.gallery-item {
  cursor: pointer;
  overflow: hidden;
  border-radius: 10px;
  box-shadow: 0 4px 14px rgb(74 20 140 / 0.4);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.gallery-item:hover,
.gallery-item:focus {
  transform: scale(1.05);
  box-shadow: 0 8px 30px rgb(74 20 140 / 0.7);
  outline: none;
}
.gallery-item img {
  width: 100%;
  height: auto;
  display: block;
  object-fit: contain;
  background-color: #fff;
  padding: 0.5rem;
}
.lightbox {
  position: fixed;
  top: 0; left: 0;
  width: 100vw; height: 100vh;
  background: rgba(74, 20, 140, 0.85);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  animation: fadeIn 0.35s ease forwards;
  z-index: 1000;
  cursor: zoom-out;
  color: #eee;
}
.lightbox img {
  max-width: 90%;
  max-height: 80vh;
  border-radius: 12px;
  box-shadow: 0 6px 20px rgba(0,0,0,0.7);
}
.lightbox-close {
  position: absolute;
  top: 1.2rem;
  right: 1.5rem;
  font-size: 3rem;
  color: #eee;
  cursor: pointer;
  user-select: none;
  transition: color 0.2s ease;
}
.lightbox-close:hover {
  color: #ff4081;
}
.lightbox p {
  margin-top: 1rem;
  font-size: 1.2rem;
  font-weight: 600;
  text-shadow: 1px 1px 5px rgba(0,0,0,0.5);
  user-select: none;
}
@keyframes fadeIn {
  from {opacity:0;}
  to {opacity:1;}
}
EOF

echo "✅ Gallery.css écrasé."

# JS
cat > src/pages/Gallery.js << 'EOF'
import React, { useState } from 'react';
import './Gallery.css';

const images = [
  { id: 1, src: '/assets/media/logos/logo192.png', alt: 'Logo 192' },
  { id: 2, src: '/assets/media/logos/logo512.png', alt: 'Logo 512' },
  { id: 3, src: '/assets/media/logos/logo-react.svg', alt: 'Logo React' },
];

export default function Gallery() {
  const [selected, setSelected] = useState(null);

  const openLightbox = (img) => setSelected(img);
  const closeLightbox = () => setSelected(null);

  return (
    <div className="gallery-container">
      <h2>Galerie LuxeEvents</h2>
      <div className="gallery-grid">
        {images.map(img => (
          <div
            key={img.id}
            className="gallery-item"
            onClick={() => openLightbox(img)}
            role="button"
            tabIndex={0}
            onKeyDown={e => { if (e.key === 'Enter') openLightbox(img); }}
          >
            <img src={img.src} alt={img.alt} loading="lazy" />
          </div>
        ))}
      </div>

      {selected && (
        <div className="lightbox" onClick={closeLightbox} role="dialog" aria-modal="true">
          <span className="lightbox-close" onClick={closeLightbox}>&times;</span>
          <img src={selected.src} alt={selected.alt} />
          <p>{selected.alt}</p>
        </div>
      )}
    </div>
  );
}
EOF

echo "✅ Gallery.js écrasé."

echo "N’oublie pas de redémarrer ton serveur dev : npm start ou yarn start."

echo "🔥 Nova déploiement terminé. Ton site va briller comme jamais."
