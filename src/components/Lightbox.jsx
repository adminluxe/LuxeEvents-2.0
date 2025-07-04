import React, { useState } from 'react'
import Modal from 'react-modal'
import { motion } from 'framer-motion'

Modal.setAppElement('#root')

export default function Lightbox({ src, alt, siblings = [], currentIndex = 0, onNavigate }) {
  const [open, setOpen] = useState(false)
  const [index, setIndex] = useState(currentIndex)

  const next = () => setIndex((i) => (i + 1) % siblings.length)
  const prev = () => setIndex((i) => (i - 1 + siblings.length) % siblings.length)

  return (
    <>
      <img src={src} alt={alt} className="cursor-pointer" onClick={() => setOpen(true)} />
      <Modal
        isOpen={open}
        onRequestClose={() => setOpen(false)}
        className="fixed inset-0 flex items-center justify-center bg-black/90 p-4"
      >
        <motion.img
          key={siblings[index]}
          src={siblings[index]}
          alt={`${alt} ${index+1}`}
          initial={{ opacity: 0, scale: 0.8 }}
          animate={{ opacity: 1, scale: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.4 }}
          className="max-h-full max-w-full"
        />
        <button onClick={prev} className="absolute left-4 top-1/2 text-ivory text-4xl">‹</button>
        <button onClick={next} className="absolute right-4 top-1/2 text-ivory text-4xl">›</button>
        <div className="absolute bottom-8 flex space-x-2">
          {siblings.map((s, i) => (
            <img
              key={s}
              src={s}
              alt=""
              className={`w-16 h-10 object-cover rounded ${i===index?'ring-2 ring-gold':''}`}
              onClick={() => setIndex(i)}
            />
          ))}
        </div>
      </Modal>
    </>
  )
}
