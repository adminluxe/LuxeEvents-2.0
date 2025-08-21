"use client";

export default function StoryGalleryResponsive() {
  return (
    <div className="p-6">
      <h2 className="text-2xl font-bold mb-4 text-gold">Galerie immersive</h2>
      <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4">
        {[...Array(30)].map((_, i) => (
          <img
            key={i}
            src={`/images/story/story-${i + 1}.webp`}
            alt={`Story ${i + 1}`}
            className="rounded-lg shadow-md hover:scale-105 transition-transform"
          />
        ))}
      </div>
    </div>
  );
}
