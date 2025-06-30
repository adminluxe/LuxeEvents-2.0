import React from 'react'
const images = ['/assets/image1.jpg','/assets/image10.jpg','/assets/image11.png','/assets/image12.jpg']
export default function Gallery() {
  return (
    <section className="py-16 bg-ivory bg-opacity-80 rounded-lg">
      <h2 className="text-3xl font-serif text-luxeGold mb-8 text-center">Moments d’Exception</h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
        {images.map((src,i)=><div key={i} className="overflow-hidden rounded-lg shadow-lg"><img src={src} alt={\`Moment \${i+1}\`} className="w-full h-48 object-cover hover:scale-105 transition-transform duration-300"/></div>)}
      </div>
    </section>
  )
}
