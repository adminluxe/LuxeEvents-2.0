import React from "react";

export default function ImageCard({ src, alt = "", fallback = "/media/images/placeholder-luxe.jpg" }) {
  const handleError = (e) => {
    e.target.src = fallback;
  };

  return (
    <div className="aspect-[4/3] w-full overflow-hidden rounded-2xl shadow-lg border border-[#d4af37] bg-white/10 backdrop-blur-sm">
      <img
        src={src}
        alt={alt}
        onError={handleError}
        className="w-full h-full object-cover transition-transform duration-300 hover:scale-105"
      />
    </div>
  );
}
