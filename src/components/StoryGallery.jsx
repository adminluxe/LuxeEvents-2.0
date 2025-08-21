"use client";

import React from "react";
import LazyImage from "./LazyImage";

const images = [
  "/images/story/story-1.webp",
  "/images/story/story-2.webp",
  "/images/story/story-3.webp",
  "/images/story/story-4.webp",
  "/images/story/story-5.webp",
  "/images/story/story-6.webp",
  "/images/story/story-7.webp",
  "/images/story/story-8.webp",
  "/images/story/story-9.webp",
  "/images/story/story-10.webp",
  "/images/story/story-11.webp",
  "/images/story/story-12.webp",
  "/images/story/story-13.webp",
  "/images/story/story-14.webp",
  "/images/story/story-15.webp",
  "/images/story/story-16.webp",
  "/images/story/story-17.webp",
  "/images/story/story-18.webp",
  "/images/story/story-25.webp",
];

export default function StoryGallery() {
  return (
    <div className="p-8 bg-black text-white min-h-screen">
      <h1 className="text-2xl font-bold mb-4 text-gold">Prévisualisation des images story</h1>
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {images.map((src, i) => (
          <div key={i} className="bg-white p-1 rounded shadow">
            <img src={src} alt={`story-${i + 1}`} className="w-full h-auto rounded" />
            <p className="text-center text-xs mt-1 text-black">{src.split('/').pop()}</p>
          </div>
        ))}
      </div>
    </div>
  );
}
