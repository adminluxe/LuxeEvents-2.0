"use client";

import React, { useState } from "react";

const initialImages = Array.from({ length: 30 }, (_, i) => `/images/story/story-${i + 1}.webp`);

export default function StoryGalleryAdmin() {
  const [images, setImages] = useState(initialImages.filter(src => ![19,20,21,22,23,24].includes(parseInt(src.match(/\d+/)))));

  const handleDelete = (src) => {
     
    fetch(`/delete-image?name=${name}`)
    fetch(`/delete-image?name=${name}`)
      .then(() => setImages(images.filter((img) => img !== src)))
      .catch((err) => console.error("❌ Erreur suppression :", err));
  };

  return (
    <div className="p-8 bg-black text-white min-h-screen">
      <h1 className="text-2xl font-bold mb-4 text-gold">Galerie Story Admin</h1>
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {images.map((src, i) => (
          <div key={i} className="bg-white p-2 rounded shadow relative">
            <img src={src} alt={`story-${i + 1}`} className="w-full h-auto rounded mb-2" />
            <p className="text-center text-xs text-black mb-1">{src.split("/").pop()}</p>
            <button
              onClick={() => handleDelete(src)}
              className="absolute top-1 right-1 bg-red-600 text-white text-xs px-2 py-1 rounded hover:bg-red-800"
            >
              🗑 Supprimer
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}
