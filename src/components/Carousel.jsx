import { useState, useRef, useEffect } from 'react'

const media = [
  { type: 'image', src: '/assets/image1.jpg', alt: 'Image 1' },
  { type: 'image', src: '/assets/image10.jpg', alt: 'Image 10' },
  { type: 'image', src: '/assets/image11.png', alt: 'Image 11' },
  { type: 'image', src: '/assets/image12.jpg', alt: 'Image 12' },
]

export default function Carousel() {
  const [idx, setIdx] = useState(0)
  const wrapper = useRef()

  const next = () => setIdx(i => i === media.length - 1 ? 0 : i + 1)
  const prev = () => setIdx(i => i === 0 ? media.length - 1 : i - 1)

  useEffect(() => {
    const width = wrapper.current.clientWidth
    wrapper.current.style.transition = 'transform 0.5s ease-in-out'
    wrapper.current.style.transform = `translateX(-${idx * width}px)`
  }, [idx])

  return (
    <div className="relative overflow-hidden w-full bg-ivory">
      <div ref={wrapper} className="flex">
        {media.map((m, i) => (
          <div key={i} className="w-full flex-shrink-0 flex items-center justify-center">
            <img
              src={m.src}
              alt={m.alt}
              className="object-cover w-full h-[500px]"
            />
          </div>
        ))}
      </div>
      <button onClick={prev}
              className="absolute left-4 top-1/2 -translate-y-1/2 bg-gold text-luxeWhite p-4 rounded-full hover:bg-yellow">
        ‹
      </button>
      <button onClick={next}
              className="absolute right-4 top-1/2 -translate-y-1/2 bg-gold text-luxeWhite p-4 rounded-full hover:bg-yellow">
        ›
      </button>
    </div>
  )
}
