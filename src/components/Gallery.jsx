import React from 'react'

export default function Gallery({ images = [] }) {
  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
      {images.map((src, i) => (
        <div key={i} className="overflow-hidden rounded-lg shadow-lg">
          <img
            src={src}
            alt={'Moment ' + (i + 1)}
            className="w-full h-48 object-cover hover:scale-105 transition-transform duration-300"
          />
        </div>
      ))}
    </div>
  )
}
