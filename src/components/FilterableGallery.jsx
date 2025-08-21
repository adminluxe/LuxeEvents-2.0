import React, { useMemo, useState, useEffect } from "react";
export default function FilterableGallery({ items = [] }){
  const cats = useMemo(() => ["tous", ...Array.from(new Set(items.map(i => i.cat)))], [items]);
  const [cat, setCat] = useState("tous");
  const filtered = useMemo(() => cat==="tous" ? items : items.filter(i => i.cat===cat), [items, cat]);
  const [open, setOpen] = useState(false);
  const [current, setCurrent] = useState(null);
  useEffect(() => { const f = e => e.key==="Escape" && setOpen(false); document.addEventListener("keydown", f); return () => document.removeEventListener("keydown", f); },[]);
  return (
    <div>
      <div className="flex flex-wrap gap-2 mb-6" role="tablist" aria-label="Filtre catégories">
        {cats.map(c => (
          <button key={c} role="tab" aria-selected={cat===c} onClick={() => setCat(c)}
            className={"px-3 py-1.5 rounded-full text-sm border " + (cat===c ? "bg-white text-black border-white" : "border-white/30 text-white/90 hover:border-white/60")}>
            {c==="tous" ? "Tous" : c.charAt(0).toUpperCase()+c.slice(1)}
          </button>
        ))}
      </div>
      <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {filtered.map(card => (
          <article key={card.id} className="rounded-2xl overflow-hidden bg-white/5 border border-white/10">
            <button onClick={() => { setCurrent(card); setOpen(true); }} className="block w-full" aria-label={"Agrandir : " + (card.title || card.alt || "visuel")}>
              <img src={card.img} alt={card.alt} loading="lazy" className="w-full aspect-[16/9] object-cover" />
            </button>
            <div className="p-4">
              <h3 className="text-lg font-semibold">{card.title}</h3>
              <p className="text-white/70 text-xs mt-1 uppercase tracking-wide">{card.cat}</p>
            </div>
          </article>
        ))}
      </div>
      {open && current && (
        <div className="fixed inset-0 z-50 bg-black/80 grid place-items-center p-4" role="dialog" aria-modal="true">
          <button onClick={() => setOpen(false)} className="absolute top-4 right-4 px-3 py-1 rounded-lg bg-white/10 hover:bg-white/20 text-white" aria-label="Fermer la visionneuse">✕</button>
          <figure className="max-w-5xl w-full">
            <img src={current.img} alt={current.alt} className="w-full h-auto rounded-xl" />
            {current.title && <figcaption className="text-white/80 text-sm mt-2">{current.title}</figcaption>}
          </figure>
        </div>
      )}
    </div>
  );
}
