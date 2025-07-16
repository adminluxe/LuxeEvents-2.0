import { motion } from "framer-motion";
import { useRef } from "react";
import useEmblaCarousel from "embla-carousel-react";

const slides = [
  {
    title: "Notre genèse",
    description: "LuxeEvents est né d’un rêve : rendre le luxe accessible sans compromis.",
    image: "/images/story-1.jpg",
  },
  {
    title: "Une vision élégante",
    description: "Une nouvelle ère d’événementiel immersive, poétique, raffinée.",
    image: "/images/story-2.jpg",
  },
  {
    title: "Un futur en mouvement",
    description: "L’innovation au service de l’émotion, pour chaque instant de vie.",
    image: "/images/story-3.jpg",
  },
];

export default function SwiperStory() {
  const [emblaRef] = useEmblaCarousel({ loop: true });
  return (
    <section className="h-screen w-full bg-black text-white scroll-snap-start overflow-hidden">
      <div className="overflow-hidden h-full" ref={emblaRef}>
        <div className="flex h-full">
          {slides.map((slide, index) => (
            <motion.div
              key={index}
              className="min-w-full h-full flex flex-col items-center justify-center bg-cover bg-center px-8"
              style={{ backgroundImage: `url(${slide.image})` }}
              initial={{ opacity: 0, scale: 0.9 }}
              whileInView={{ opacity: 1, scale: 1 }}
              viewport={{ once: true }}
              transition={{ duration: 0.8 }}
            >
              <h2 className="text-4xl sm:text-5xl font-bold text-yellow-400 drop-shadow-md">
                {slide.title}
              </h2>
              <p className="mt-4 max-w-xl text-lg text-ivory backdrop-blur">
                {slide.description}
              </p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
