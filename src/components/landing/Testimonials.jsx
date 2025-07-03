import React from 'react'
import { motion } from "framer-motion";
import { useTestimonials } from '../../hooks/useTestimonials'

export default function Testimonials() {
  const container = { hidden: {}, show: { transition: { staggerChildren: 0.2 } } };
  const item = { hidden: { opacity:0, y:20 }, show: { opacity:1, y:0 } };
  return (<motion.section initial="hidden" animate="show" variants={container} className="py-16 bg-white">() {
  const data = useTestimonials()
  return (
    <section className="py-16 bg-white">
      <h2 className="text-3xl text-center mb-8">Ils ont vécu l’Exception</h2>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8 px-4">
        {data.map(({ id, attributes }) => (
          <motion.figure variants={item} key={id} className="text-center">
            <LazyLoad><img src={attributes.photo.data.attributes.url}
                 alt={attributes.name}
                 className="w-24" /></LazyLoad> h-24 rounded-full mx-auto mb-4" />
            <blockquote className="italic">&ldquo;{attributes.quote}&rdquo;</blockquote>
            <figcaption className="mt-2 font-bold">{attributes.name}</figcaption>
            <small className="block text-gray-500">{attributes.role}</small>
          </motion.figure>
        ))}
      </div>
    </section>
  )
}
