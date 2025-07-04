import React from 'react'
import Tilt from 'react-parallax-tilt'

export default function Gallery({ images }) {
  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
      {images.map((src, i) => (
        <Tilt key={i} glareEnable glareMaxOpacity={0.2} className="rounded-2xl overflow-hidden shadow-xl">
          <figure className="group relative">
            <img src={src} alt={`Galerie ${i + 1}`} className="w-full h-64 object-cover transition-transform duration-700 group-hover:scale-105\" />
          </figure>
        </Tilt>
      ))}
    </div>
  )
}
