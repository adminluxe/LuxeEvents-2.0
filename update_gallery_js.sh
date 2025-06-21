#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'update_gallery_js'. Description à compléter.
mkdir -p src/pages

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
            onKeyDown={e => { if(e.key === 'Enter') openLightbox(img) }}
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

echo "✅ src/pages/Gallery.js mis à jour avec brio."
