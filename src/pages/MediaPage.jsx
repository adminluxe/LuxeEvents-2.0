import React from "react";

export default function MediaPage() {
  return (
    <div className="relative min-h-screen flex flex-col justify-center items-center text-white text-center px-6 pt-32">
      <div className="absolute inset-0 bg-black/40 -z-10" />
      <h2 className="text-4xl md:text-5xl font-bold text-[#d4af37] mb-4 drop-shadow-lg">
        Bientôt une galerie immersive...
      </h2>
      <p className="text-white/70 max-w-xl">
        Des images, des vidéos et des souvenirs inoubliables, soigneusement sélectionnés pour vous plonger dans notre univers.
      </p>
    </div>
  );
}
