import { Swiper, SwiperSlide } from 'swiper/react';
import 'swiper/css';
import { motion } from 'framer-motion';
import { Quote } from 'lucide-react';

const testimonials = [
  { name: 'Élise Martin', text: 'Une expérience hors du commun, chaque détail était parfait.' },
  { name: 'Julien Dubois', text: 'Un service VIP, des émotions sans limite, je recommande !' },
  { name: 'Camille Lefèvre', text: 'LuxeEvents a redéfini mes attentes, sublime et innovant.' },
];

export default function Testimonials() {
  return (
    <section className="py-20 bg-gray-100">
      <h2 className="text-4xl font-serif text-center mb-12">Ils ont vécu l’Exception</h2>
      <Swiper
        spaceBetween={50}
        slidesPerView={1}
        loop
        autoplay={{ delay: 4000 }}
        style={{ padding: '0 2rem' }}
      >
        {testimonials.map((t, i) => (
          <SwiperSlide key={i}>
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.4 }}
              className="bg-white p-8 rounded-2xl shadow-lg max-w-xl mx-auto text-center"
            >
              <Quote className="w-10 h-10 mx-auto text-luxeGold mb-4" />
              <p className="text-lg italic mb-4">“{t.text}”</p>
              <span className="font-semibold">{t.name}</span>
            </motion.div>
          </SwiperSlide>
        ))}
      </Swiper>
    </section>
  );
}
