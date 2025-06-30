import { useState } from 'react';
import { motion } from 'framer-motion';

export default function Gallery() {
  const photos = [
    { src: '/assets/p1.jpg', caption: 'Cocktail chic au coucher du soleil' },
    { src: '/assets/p2.jpg', caption: 'Salle grandiose, invités élégants' },
    { src: '/assets/p3.jpg', caption: 'Dîner sous lustres dorés' },
    { src: '/assets/p4.jpg', caption: 'After-party en plein air' },
  ];
  const [lightbox, setLightbox] = useState(null);

  return (
    <section className="py-20 bg-gray-50">
      <h2 className="text-4xl font-serif text-center mb-8">Moments d’Exception</h2>
      <div className="grid grid-cols-2 md:grid-cols-4 gap-6 px-4">
        {photos.map(({ src, caption }, i) => (
          <motion.div
            key={i}
            whileHover={{ scale: 1.03 }}
            className="relative cursor-pointer overflow-hidden rounded-lg shadow-lg"
            onClick={() => setLightbox(src)}
          >
            <img src={src} className="w-full h-40 object-cover" />
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileHover={{ opacity: 1, y: 0 }}
              className="absolute bottom-0 left-0 right-0 bg-black/60 text-white text-sm p-2"
            >
              {caption}
            </motion.div>
          </motion.div>
        ))}
      </div>

      {lightbox && (
        <div
          onClick={() => setLightbox(null)}
          className="fixed inset-0 bg-black/80 flex items-center justify-center p-4"
        >
          <motion.img
            src={lightbox}
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ duration: 0.4 }}
            className="max-h-[90%] max-w-[90%] rounded-lg"
          />
        </div>
      )}
    </section>
  );
}
