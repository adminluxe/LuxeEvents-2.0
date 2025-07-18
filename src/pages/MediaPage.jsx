import React from "react";
import ImageCard from "@/components/ImageCard";

const imagePaths = Array.from({ length: 25 }, (_, i) =>
  `/media/images/photo-${String(i + 1).padStart(3, "0")}.webp`
);

const videoPaths = Array.from({ length: 8 }, (_, i) =>
  `/media/videos/video-${String(i + 1).padStart(3, "0")}.mp4`
);

export default function MediaPage() {
  return (
    <div className="relative min-h-screen p-6 pt-24 text-white">
      <div className="absolute inset-0 bg-black/40 -z-10" />
      <h2 className="text-4xl md:text-5xl font-bold text-[#d4af37] mb-8 text-center drop-shadow-lg">
        Galerie immersive
      </h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        {imagePaths.map((src, i) => (
          <ImageCard key={i} src={src} alt={`Photo ${i + 1}`} />
        ))}
        {videoPaths.map((src, i) => (
          <video
            key={`video-${i}`}
            src={src}
            controls
            className="aspect-[4/3] w-full rounded-2xl shadow-lg border border-[#d4af37] bg-black/20 backdrop-blur-sm object-cover"
          />
        ))}
      </div>
    </div>
  );
}
