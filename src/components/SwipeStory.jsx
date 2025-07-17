import { Swiper, SwiperSlide } from "swiper/react";
import { EffectCoverflow } from "swiper/modules";
import "swiper/css";
import "swiper/css/effect-coverflow";

const slides = [
  { title: "L'Idée", text: "Rendre le luxe événementiel universel." },
  { title: "La Vision", text: "Fusionner élégance, tech et émotion." },
  { title: "La Réalité", text: "LuxeEvents, l’expérience réinventée." }
];

export default function SwipeStory() {
  return (
    <section className="bg-white dark:bg-zinc-900 py-20 px-4 scroll-snap-start">
      <div className="max-w-5xl mx-auto text-center">
        <Swiper
          effect={"coverflow"}
          grabCursor={true}
          centeredSlides={true}
          slidesPerView={"auto"}
          coverflowEffect={{
            rotate: 50,
            stretch: 0,
            depth: 100,
            modifier: 1,
            slideShadows: true,
          }}
          modules={[EffectCoverflow]}
          className="mySwiper"
        >
          {slides.map((s, i) => (
            <SwiperSlide key={i} className="w-64 bg-yellow-100 dark:bg-zinc-700 p-6 rounded-xl shadow-lg">
              <h3 className="text-xl font-semibold mb-2 text-zinc-800 dark:text-yellow-50">{s.title}</h3>
              <p className="text-zinc-600 dark:text-zinc-200">{s.text}</p>
            </SwiperSlide>
          ))}
        </Swiper>
      </div>
    </section>
  );
}
