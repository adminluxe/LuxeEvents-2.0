#!/usr/bin/env bash
set -euo pipefail

echo "🌊 Démarrage du setup Immersive Experience…"

# 1) Installation des libs
echo "1) Installing react-intersection-observer, framer-motion, react-image-lightbox…"
npm install react-intersection-observer framer-motion react-image-lightbox --save

# 2) Hero Parallaxe
echo "2) Patch Hero.jsx for parallax effect…"
perl -i -0777 -pe '
  s|(import React[^\n]*\n)|$1import { motion, useViewportScroll, useTransform } from "framer-motion"\n|;
  s|export default function Hero\(\) \{|export default function Hero() {\
  const { scrollY } = useViewportScroll();\
  const y1 = useTransform(scrollY, [0, 300], [0, -100]);\
|;
  s|<video([^>]*)>|<motion.video\1 style={{ y: y1 }}>|g;
  s|</video>|</motion.video>|g;
' src/components/landing/Hero.jsx

# 3) Reveal-on-Scroll (Prestations & Contact)
echo "3) Add scroll-reveal wrappers on Prestations & Contact…"
for page in src/pages/Prestations.jsx src/pages/Contact.jsx; do
  perl -i -0777 -pe '
    s|(import React[^\n]*\n)|$1import { useInView } from "react-intersection-observer";\nimport { motion } from "framer-motion";\n|;
    s|export default function ([^\(\)]+)\(\) \{|export default function \1() {\
  const [ref, inView] = useInView({ triggerOnce: true, threshold: 0.2 });\
|;
    s|return \(|return (<motion.div ref={ref} initial={{ opacity: 0, y: 30 }} animate={inView ? { opacity: 1, y: 0 } : {}}>\n  (|g;
    s|\);\s*$|  )\n</motion.div>);|g;
  ' "$page"
done

# 4) Lightbox in GalleryDetail
echo "4) Add Lightbox in GalleryDetail.jsx…"
perl -i -0777 -pe '
  s|(import Slider[^\n]*\n)|$1import React, { useState } from "react";\nimport Lightbox from "react-image-lightbox";\nimport "react-image-lightbox/style.css"\n|;
  s|export default function GalleryDetail\(\) \{|export default function GalleryDetail() {\
  const [isOpen, setIsOpen] = useState(false);\
  const [photoIndex, setPhotoIndex] = useState(0);\
|;
  s|<Slider([^>]*)>([\s\S]*?)</Slider>|<Slider\1>\2</Slider>\
{isOpen && (<Lightbox\
  mainSrc={gallery.data[photoIndex].attributes.url}\
  nextSrc={gallery.data[(photoIndex+1)%gallery.data.length].attributes.url}\
  prevSrc={gallery.data[(photoIndex+gallery.data.length-1)%gallery.data.length].attributes.url}\
  onCloseRequest={()=>setIsOpen(false)}\
  onMovePrevRequest={()=>setPhotoIndex((photoIndex+gallery.data.length-1)%gallery.data.length)}\
  onMoveNextRequest={()=>setPhotoIndex((photoIndex+1)%gallery.data.length)}\
/>)}|g;
  s|<img([^>]*)alt=|<img\1 onClick={()=>{ setIsOpen(true); setPhotoIndex(id); }} style={{ cursor: "pointer" }} alt=|g;
' src/components/landing/GalleryDetail.jsx

# 5) Animate Testimonials
echo "5) Animate Testimonials section…"
perl -i -0777 -pe '
  s|(import React[^\n]*\n)|$1import { motion } from "framer-motion";\n|;
  s|export default function Testimonials|export default function Testimonials() {\
  const container = { hidden: {}, show: { transition: { staggerChildren: 0.2 } } };\
  const item = { hidden: { opacity:0, y:20 }, show: { opacity:1, y:0 } };\
  return (<motion.section initial="hidden" animate="show" variants={container} className="py-16 bg-white">|s;
  s|<figure key|<motion.figure variants={item} key|g;
  s|</figure>|</motion.figure>|g;
' src/components/landing/Testimonials.jsx

echo "✅ Setup Immersive Experience terminé !"
echo "→ Relance vite : npm run dev -- --host"
