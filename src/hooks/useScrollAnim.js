import { useRef, useEffect } from 'react'
export function useScrollAnim(callback, options={}) {
  const ref = useRef(null)
  useEffect(() => {
    const obs = new IntersectionObserver(([e]) => { if(e.isIntersecting) callback(ref.current) }, options)
    if (ref.current) obs.observe(ref.current)
    return () => obs.disconnect()
  }, [])
  return ref
}
