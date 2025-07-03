import React from 'react'
import { useParams } from 'react-router-dom'
import { useMoment } from '../../hooks/useMoment'
import Slider from 'react-slick'
import React, { useState } from "react";
import Lightbox from "react-image-lightbox";
import "react-image-lightbox/style.css"

export default function GalleryDetail() {
  const [isOpen, setIsOpen] = useState(false);
  const [photoIndex, setPhotoIndex] = useState(0);

  const { slug } = useParams()
  const { item, loading, error } = useMoment(slug)

  if (loading) return <p>Chargement…</p>
  if (error || !item) return <p>Oups, moment introuvable.</p>

  const { title, description, date, theme, price, gallery } = item

  const settings = {
    dots: true,
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
  }

  return (
    <motion.div className="mx-auto max-w-4xl p-4" initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.6 }}>
      <h1 className="text-4xl font-bold mb-4">{title}</h1>
      <p className="text-gray-600 mb-6" dangerouslySetInnerHTML={{ __html: description }} />
      <div className="mb-6">
        <span className="mr-4">📅 {new Date(date).toLocaleDateString()}</span>
        <span className="mr-4">🎨 {theme}</span>
        <span>💶 {price} €</span>
      </motion.div>
      <Slider {...settings}>
        {gallery.data.map(({ id, attributes }) => (
          <div key={id}>
            <LazyLoad><img src={attributes.url}
               onClick={()=>{ setIsOpen(true); setPhotoIndex(id); }} style={{ cursor: "pointer" }} alt={`Galerie ${id}`}
              className="w-full h-96" /></LazyLoad> object-cover rounded-lg"
            />
          </div>
        ))}
      </Slider>
{isOpen && (<Lightbox
  mainSrc={gallery.data[photoIndex].attributes.url}
  nextSrc={gallery.data[(photoIndex+1)%gallery.data.length].attributes.url}
  prevSrc={gallery.data[(photoIndex+gallery.data.length-1)%gallery.data.length].attributes.url}
  onCloseRequest={()=>setIsOpen(false)}
  onMovePrevRequest={()=>setPhotoIndex((photoIndex+gallery.data.length-1)%gallery.data.length)}
  onMoveNextRequest={()=>setPhotoIndex((photoIndex+1)%gallery.data.length)}
/>)}
    </div>
  )
}
