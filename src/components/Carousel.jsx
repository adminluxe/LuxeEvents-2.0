import { useState } from "react"
import { FaChevronLeft, FaChevronRight } from "react-icons/fa"

export default function Carousel({ images }) {
  const [idx, setIdx] = useState(0)
  const prev = () => setIdx((idx + images.length - 1) % images.length)
  const next = () => setIdx((idx + 1) % images.length)

  return (
    <div className="relative">
      <img src={images[idx]} alt={`slide-${idx}`} className="rounded-2xl shadow-2xl w-full h-auto object-cover" />
      <button onClick={prev} className="absolute top-1/2 left-4 transform -translate-y-1/2 p-3 bg-accent bg-opacity-50 rounded-full">
        <FaChevronLeft size={24} />
      </button>
      <button onClick={next} className="absolute top-1/2 right-4 transform -translate-y-1/2 p-3 bg-accent bg-opacity-50 rounded-full">
        <FaChevronRight size={24} />
      </button>
    </div>
  )
}
