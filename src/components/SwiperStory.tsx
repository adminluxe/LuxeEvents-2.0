'use client';
import { Swiper, SwiperSlide } from 'swiper/react';
import 'swiper/css';

export default function SwiperStory() {
  const stories = [
    { title: "Une vision", desc: "Créer des événements qui marquent les esprits." },
    { title: "Un savoir-faire", desc: "Allier luxe, accessibilité et innovation." },
    { title: "Une promesse", desc: "Faire de chaque instant un souvenir mémorable." },
  ];

  return (
    <div className="max-w-2xl mx-auto">
      <Swiper spaceBetween={30} slidesPerView={1}>
        {stories.map((s, i) => (
          <SwiperSlide key={i}>
            <div className="p-6 bg-white text-black rounded-xl shadow-md">
              <h3 className="text-xl font-bold mb-2">{s.title}</h3>
              <p>{s.desc}</p>
            </div>
          </SwiperSlide>
        ))}
      </Swiper>
    </div>
  );
}
