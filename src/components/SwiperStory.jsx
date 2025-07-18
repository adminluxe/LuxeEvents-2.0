import { motion } from "framer-motion";

export default function SwiperStory() {
  const slides = [
    { img: "/media/images/photo-002.webp", txt: "Des souvenirs impérissables…" },
    { img: "/media/images/photo-004.webp", txt: "L’art de la mise en scène…" },
    { img: "/media/images/photo-013.webp", txt: "Le raffinement à chaque instant" },
  ];

  return (
    <section id="story" className="scroll-snap-start w-full h-screen bg-ivory flex items-center justify-center px-4">
      <div className="max-w-4xl w-full space-y-12 text-center">
        {slides.map((s, i) => (
          <motion.div
            key={i}
            initial={{ opacity: 0, y: 40 }}
            whileInView={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            viewport={{ once: true }}
            className="space-y-4"
          >
            <img
              src={s.img}
              onError={(e) => (e.currentTarget.src = "/media/images/placeholder.jpg")}
              alt={`Slide ${i}`}
              className="mx-auto max-h-[480px] object-cover rounded-xl shadow-lg"
            />
            <p className="text-xl text-gold font-medium">{s.txt}</p>
          </motion.div>
        ))}
      </div>
    </section>
  );
}
