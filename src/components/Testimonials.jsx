import { useState,useEffect } from 'react'
const data=[
  {quote:"Une expérience hors du commun, chaque détail était parfait.",author:"Élise Martin"},
  {quote:"Un service VIP, des émotions sans limite, je recommande !",author:"Julien Dubois"},
  {quote:"LuxeEvents a redéfini mes attentes, sublime et innovant.",author:"Camille Lefèvre"}
]
export default function Testimonials() {
  const [i,setI]=useState(0)
  useEffect(()=>{
    const id=setInterval(()=>setI(i=> (i+1)%data.length),10000)
    return()=>clearInterval(id)
  },[])
  const {quote,author}=data[i]
  return (
    <section className="py-16 bg-ivory">
      <blockquote className="max-w-2xl mx-auto text-center italic text-xl">“{quote}”<footer className="mt-4 font-semibold">— {author}</footer></blockquote>
    </section>
  )
}
