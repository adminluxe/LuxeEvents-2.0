import React, { useState } from "react";
import SmartImage from "../components/SmartImage.jsx";
import Lightbox from "../components/Lightbox.jsx";
import { SchemaRealisations } from "../components/SchemaSite.jsx"; // si déjà présent, garde-le

const items = [
  { id:"m1", title:"Mariage d’exception – Château de X", cat:"mariage", img:"/images/gallery/thumb1.webp", alt:"Décor de mariage luxe au château" },
  { id:"c1", title:"Gala Corporate – Grand Hôtel", cat:"corporate", img:"/images/gallery/thumb2.webp", alt:"Soirée corporate haut de gamme" },
  { id:"p1", title:"Anniversaire Prestige – Villa privée", cat:"prive", img:"/images/gallery/thumb3.webp", alt:"Ambiance prestige dans une villa" },
];

export default function Realisations(){
  const [lb, setLb] = useState({ open:false, src:"", alt:"" });

  return (
    <main className="min-h-screen bg-[#0b0b0b] text-white pt-20">
      <SchemaRealisations />
      <section className="container mx-auto px-4 py-10">
        <h1 className="section-title text-3xl md:text-4xl mb-6">Nos réalisations</h1>
        <p className="muted-contrast mb-8">Une sélection de projets — élégance, précision, émotion.</p>

        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {items.map(card => (
            <article
              key={card.id}
              className="rounded-2xl overflow-hidden bg-white/5 border border-white/10 cursor-zoom-in"
              onClick={() => setLb({ open:true, src: card.img, alt: card.alt })}
            >
              <SmartImage
                src={card.img}
                alt={card.alt}
                width={16}
                height={9}
                className="w-full"
              />
              <div className="p-4">
                <h3 className="text-xl font-semibold">{card.title}</h3>
                <p className="text-white/70 text-sm mt-1 uppercase tracking-wide">{card.cat}</p>
              </div>
            </article>
          ))}
        </div>
      </section>

      <Lightbox open={lb.open} src={lb.src} alt={lb.alt} onClose={() => setLb({ open:false, src:"", alt:"" })} />
    </main>
  );
}
