import { Swiper, SwiperSlide } from "swiper/react";
import { EffectFade, Pagination, Autoplay } from "swiper/modules";
import { motion } from "framer-motion";
import "swiper/css";
import "swiper/css/effect-fade";
import "swiper/css/pagination";
import "swiper/css/autoplay";

const images = Array.from({ length: 25 }, (_, i) => "/images/story/story-" + (i + 1) + ".webp")

export default function StorySwiper() {
  return (
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
  );
}
