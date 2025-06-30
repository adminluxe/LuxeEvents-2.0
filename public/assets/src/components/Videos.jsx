import { Swiper, SwiperSlide } from 'swiper/react'
import 'swiper/css'
import { useState } from 'react'

// Idem, on importe toutes les vidéos .mp4
const vids = import.meta.glob(
  '/public/assets/videos/*.mp4',
  { eager: true, as: 'url' }
)
const videoList = Object.values(vids)

export default function Videos() {
  const [current, setCurrent] = useState(0)

  return (
    <section className="py-20 bg-white">
      <h2 className="text-4xl font-serif text-center mb-8">Moments filmés</h2>
      <Swiper
        slidesPerView={1}
        spaceBetween={20}
        onSlideChange={(swiper) => setCurrent(swiper.activeIndex)}
      >
        {videoList.map((src, idx) => (
          <SwiperSlide key={idx} className="flex justify-center">
            <video
              src={src}
              controls
              className="max-h-80 rounded-lg shadow-lg"
            />
          </SwiperSlide>
        ))}
      </Swiper>
      <p className="text-center mt-4 text-sm text-gray-500">
        Vidéo {current + 1} / {videoList.length}
      </p>
    </section>
  )
}
