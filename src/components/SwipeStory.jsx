import React from 'react';
import { Swiper, SwiperSlide } from 'swiper/react';
import { EffectFade, Pagination } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/effect-fade';

export default function SwipeStory() {
  return (
    <section className="w-full h-[80vh] px-4">
      <Swiper
        modules={[EffectFade, Pagination]}
        effect="fade"
        pagination={{ clickable: true }}
        className="h-full"
      >
        <SwiperSlide><div className="h-full bg-black text-white flex items-center justify-center">Story 1</div></SwiperSlide>
        <SwiperSlide><div className="h-full bg-gold text-black flex items-center justify-center">Story 2</div></SwiperSlide>
        <SwiperSlide><div className="h-full bg-white text-black flex items-center justify-center">Story 3</div></SwiperSlide>
      </Swiper>
    </section>
  );
}
