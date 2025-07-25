import React from 'react';

export default function GalleryPreview() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: GalleryPreview.jsx</div>
    <section id="gallery" className="py-20 text-white text-center px-6">
      <h2 className="text-3xl md:text-4xl font-bold text-[#d4af37] mb-8">Galerie</h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6 max-w-6xl mx-auto">
        {images.map((src, index) => (
          <img key={index} src={src} alt={`Event ${index + 1}`} className="rounded-xl shadow-lg object-cover aspect-[4/3]" />
        ))}
      </div>
    </>
  );
}
