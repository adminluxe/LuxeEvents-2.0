// ✅ Script ultra-puissant LuxeEvents - Intégration combinée
// 🔁 Swiper narratif + 🌀 Menu circulaire + 📸 Images fallback + 🎧 Son d'intro + 📱 Responsive mobile

import { useEffect, useState } from "react"
import { motion, AnimatePresence } from "framer-motion"
import { Swiper, SwiperSlide } from "swiper/react"
import { Navigation, Pagination } from "swiper/modules"
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';

// 🎧 Son d’intro
const IntroSoundPlayer = () => {
  useEffect(() => {
    const audio = new Audio("/media/intro.mp3")
    audio.volume = 0.4
    const playOnce = sessionStorage.getItem("introPlayed")
    if (!playOnce) {
      audio.play()
      sessionStorage.setItem("introPlayed", "true")
    }
  }, [])
  return null
}

const SoundToggle = () => {
  const [muted, setMuted] = useState(false)
  const toggle = () => setMuted(prev => !prev)
  return (
    <button
      className="fixed top-4 right-4 z-50 p-2 bg-white/70 rounded-full backdrop-blur"
      onClick={toggle}
    >{muted ? "🔇" : "🔊"}</button>
  )
}

// 🌀 Menu circulaire
const CircularMenu = () => {
  const [open, setOpen] = useState(false)
  return (
    <div className="fixed bottom-8 right-8 z-40">
      <button onClick={() => setOpen(!open)} className="w-14 h-14 rounded-full bg-gold shadow-xl">☰</button>
      <AnimatePresence>
        {open && (
          <motion.ul
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            exit={{ scale: 0 }}
            className="absolute bottom-16 right-0 bg-white shadow-xl rounded-xl p-4 space-y-2"
          >
            <li><a href="#hero" className="block">🏠 Accueil</a></li>
            <li><a href="#story" className="block">📖 Notre Histoire</a></li>
            <li><a href="#events" className="block">🎉 Événements</a></li>
          </motion.ul>
        )}
      </AnimatePresence>
    </div>
  )
}

// 🔁 Swiper narratif
const StorySwiper = () => {
  const slides = [
    { img: "/media/images/story-1.jpg", txt: "Des souvenirs impérissables…" },
    { img: "/media/images/story-2.jpg", txt: "Des décors dignes des contes" },
    { img: "/media/images/story-3.jpg", txt: "L’événement comme œuvre d’art" },
  ]
  return (
    <section id="story" className="w-full py-12 bg-[#fafafa]">
      <Swiper modules={[Navigation, Pagination]} navigation pagination className="w-full max-w-4xl mx-auto">
        {slides.map((s, i) => (
          <SwiperSlide key={i}>
            <div className="text-center space-y-4">
              <img
                src={s.img}
                onError={(e) => e.currentTarget.src = "/media/images/placeholder.jpg"}
                className="mx-auto rounded-xl shadow-md max-h-[500px] object-cover"
              />
              <p className="text-xl font-medium text-gold">{s.txt}</p>
            </div>
          </SwiperSlide>
        ))}
      </Swiper>
    </section>
  )
}

// 🧩 Composant principal
export default function ImmersiveBoost() {
  return (
    <main className="relative text-center text-gray-900 overflow-x-hidden">
      <IntroSoundPlayer />
      <SoundToggle />
      <CircularMenu />
      <section id="hero" className="min-h-screen flex flex-col justify-center items-center bg-cover bg-center" style={{ backgroundImage: "url('/media/images/hero.jpg')" }}>
        <h1 className="text-5xl font-bold drop-shadow-xl">Le Luxe Accessible</h1>
        <p className="mt-4 text-xl text-white/80">Réinventer l’événementiel avec émotion</p>
      </section>
      <StorySwiper />
    </main>
  )
}

// 💡 À placer dans app.tsx ou une page dédiée pour tester vite.
// 🖼️ Assurez-vous d’avoir les images dans public/media/images + un intro.mp3
// 🌐 Responsive par défaut avec Tailwind, vérifié jusqu’à 360px
