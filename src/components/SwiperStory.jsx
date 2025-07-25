import React from 'react';

export default function SwiperStory() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: SwiperStory.jsx</div>
    <section id="story" className="scroll-snap-start w-full h-screen bg-ivory flex items-center justify-center px-4">
      <div className="max-w-4xl w-full space-y-12 text-center">
        {slides.map((s, i) => (
          <motion.div style={{ opacity: 1 }}
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
    </>
  );
}
