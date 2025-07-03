import React from 'react'
import { motion, useViewportScroll, useTransform } from "framer-motion"
import { motion, useViewportScroll, useTransform } from "framer-motion"
import { motion, useViewportScroll, useTransform } from "framer-motion"
export default function Hero() {
  const { scrollY } = useViewportScroll();
  const y1 = useTransform(scrollY, [0, 300], [0, -100]);

  const { scrollY } = useViewportScroll();
  const y1 = useTransform(scrollY, [0, 300], [0, -100]);
  const { scrollY } = useViewportScroll();
  const y1 = useTransform(scrollY, [0, 300], [0, -100]);
  return (
    <section className="relative h-screen bg-black text-white flex items-center justify-center">
      <img
        src="/hero.jpg"
        alt="Hero Exception"
        className="absolute inset-0 w-full h-full object-cover opacity-80"
      />
      <h1 className="relative text-5xl font-bold">Offrez l’Exception</h1>
      <button onClick={() => navigate("/reserver")} className="mt-6 bg-gold text-black px-6 py-3 rounded">Réservez maintenant</button>
    </section>
  )
}
