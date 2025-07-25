import React from 'react';

export default function TimelineSection() {
  return (
    <>
    <div className="bg-green-200 text-black p-2 text-xs uppercase tracking-widest border border-green-600 mb-2">VISIBLE: TimelineSection.jsx</div>
    <section className="bg-white text-black py-24 px-6 scroll-snap-start">
      <div className="max-w-4xl mx-auto">
        <h2 className="text-3xl md:text-4xl font-bold text-[#d4af37] drop-shadow-lg">
          Notre Timeline
        </h2>
        <div className="space-y-12">
          {milestones.map((step, index) => (
            <motion.div style={{ opacity: 1 }}
              key={index}
              initial={{ opacity: 0, y: 60 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.7, delay: index * 0.2 }}
              className="bg-ivory rounded-xl shadow-lg p-6 border-l-4 border-yellow-500"
            >
              <h3 className="text-xl font-semibold text-yellow-600">{step.year} – {step.title}</h3>
              <p className="mt-2 text-gray-800">{step.description}</p>
            </motion.div>
          ))}
        </div>
    </>
  );
}
