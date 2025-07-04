import React from 'react'

export default function Gallery({ images }) {
  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
      {images.map((src, i) => (
        <figure key={i} className="group overflow-hidden rounded-2xl shadow-xl">
          <img
            src={src}
            alt={`Galerie ${i + 1}`}
            className="w-full h-64 object-cover transition-transform duration-700 group-hover:scale-110"
          />
          <figcaption className="p-4 bg-noir/50 text-ivory opacity-0 group-hover:opacity-100 transition-opacity duration-500">
            <span className="font-sans">Image {i + 1}</span>
          </figcaption>
        </figure>
      ))}
    </div>
  )
}
