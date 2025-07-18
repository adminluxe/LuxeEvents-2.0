import React from "react";

export default function GalleryPreview() {
  const images = [
    "/media/images/demo1.jpg",
    "/media/images/demo2.jpg",
    "/media/images/demo3.jpg",
    "/media/images/demo4.jpg",
    "/media/images/demo5.jpg",
    "/media/images/demo6.jpg"
  ];

  return (
    <section id="gallery" className="py-20 text-white text-center px-6">
      <h2 className="text-3xl md:text-4xl font-bold text-[#d4af37] mb-8">Galerie</h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6 max-w-6xl mx-auto">
        {images.map((src, index) => (
          <img key={index} src={src} alt={`Event ${index + 1}`} className="rounded-xl shadow-lg object-cover aspect-[4/3]" />
        ))}
      </div>
    </section>
  );
}
