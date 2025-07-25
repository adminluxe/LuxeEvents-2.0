import React from 'react';
import { motion } from 'framer-motion';
import { Swiper, SwiperSlide } from 'swiper/react';
import { EffectFade, Pagination, Autoplay } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/effect-fade';
import 'swiper/css/pagination';

const images = [
  '/images/story/1.webp',
  '/images/story/2.webp',
  '/images/story/3.webp',
];

export default function StorySwiper() {
  return (
    <>
      <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">
        ✅ VISIBLE: StorySwiper.jsx
      </div>
      <motion.div
        className="w-full h-screen overflow-hidden bg-black"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 1 }}
      >
        <Swiper
          modules={[EffectFade, Pagination, Autoplay]}
          effect="fade"
          loop
          autoplay={{ delay: 5000, disableOnInteraction: false }}
          pagination={{ clickable: true }}
          className="w-full h-full"
        >
          {images.map((src, index) => (
            <SwiperSlide key={index}>
              <img
                src={src}
                alt={`story ${index + 1}`}
                className="object-cover w-full h-full"
                loading="lazy"
              />
            </SwiperSlide>
          ))}
        </Swiper>
      </motion.div>
    </>
  );
}
