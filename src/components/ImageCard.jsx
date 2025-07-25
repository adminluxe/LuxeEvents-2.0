import React from 'react';

export default function ImageCard() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: ImageCard.jsx</div>
    <div className="aspect-[4/3] w-full overflow-hidden rounded-2xl shadow-lg border border-[#d4af37] bg-white/10 backdrop-blur-sm">
      <img
        src={src}
        alt={alt}
        onError={handleError}
        className="w-full h-full object-cover transition-transform duration-300 hover:scale-105"
      />
    </div>
    </>
  );
}
