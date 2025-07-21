// ✅ TopBarControls.jsx
// Affiche : 🌐 switch de langue, 🌙 toggle DarkMode, 🌀 menu circulaire LuxeEvents

import { useState } from "react"
import { motion, AnimatePresence } from "framer-motion"

export default function TopBarControls() {
  const [menuOpen, setMenuOpen] = useState(false)

  return (
    <div className="fixed top-4 right-4 z-50 flex items-center space-x-3">
      {/* 🌐 Lang switch (FR/EN) */}
      <button
        className="w-10 h-10 bg-white text-sm font-bold rounded-full shadow border border-gray-200"
        onClick={() => {
          const lang = localStorage.getItem("lang") === "fr" ? "en" : "fr"
          localStorage.setItem("lang", lang)
          location.reload()
        }}
      >🌐</button>

      {/* 🌙 Dark mode toggle */}
      <button
        className="w-10 h-10 bg-white rounded-full shadow border border-gray-200"
        onClick={() => {
          const html = document.documentElement
          html.classList.toggle("dark")
        }}
      >🌙</button>

      {/* 🌀 Menu circulaire */}
      <div className="relative">
        <button
          onClick={() => setMenuOpen(!menuOpen)}
          className="w-10 h-10 rounded-full bg-gold text-white shadow-lg"
        >☰</button>

        <AnimatePresence>
          {menuOpen && (
            <motion.ul
              initial={{ opacity: 0, scale: 0.8 }}
              animate={{ opacity: 1, scale: 1 }}
              exit={{ opacity: 0, scale: 0.8 }}
              transition={{ duration: 0.2 }}
              className="absolute right-0 mt-12 bg-white shadow-xl rounded-lg p-4 space-y-2 text-sm text-gray-800"
            >
              <li><a href="#hero" className="block">🏠 Accueil</a></li>
              <li><a href="#story" className="block">📖 Notre Histoire</a></li>
              <li><a href="#events" className="block">🎉 Événements</a></li>
              <li><a href="/media" className="block">🖼️ Galerie</a></li>
            </motion.ul>
          )}
        </AnimatePresence>
      </div>
    </div>
  )
}
