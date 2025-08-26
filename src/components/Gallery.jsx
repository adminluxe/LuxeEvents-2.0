import React from "react";
const images = Array.from({length:8}, (_,i)=>`/images/gallery/thumb${i+1}.png`);
export default function GallerySection(){
  return (
    <section id="realisations" className="max-w-6xl mx-auto px-4">
      <h2 className="text-3xl md:text-4xl font-serif mb-6">Nos réalisations</h2>
      <div className="grid grid-cols-2 md:grid-cols-4 gap-3 md:gap-4">
        {images.map(src => (
          <img
            key={src}
            src={src}
            alt="Réalisation LuxeEvents"
            loading="lazy"
            className="rounded-xl shadow-sm"
            onError={(e)=>{ e.currentTarget.style.display='none'; }}
          />
        ))}
      </div>
    </section>
  );
}
