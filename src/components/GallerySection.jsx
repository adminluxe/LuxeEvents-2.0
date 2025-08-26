const IMGS = Array.from({length:8}, (_,i)=>`/images/gallery/thumb${i+1}.png`);
export default function GallerySection() {
  return (
    <section id="realisations" className="container mx-auto py-16">
      <h2 className="text-3xl font-serif mb-8">Réalisations</h2>
      <div className="grid sm:grid-cols-2 md:grid-cols-4 gap-4">
        {IMGS.map(src => (
          <img key={src} src={src} loading="lazy" alt="LuxeEvents - réalisation" className="rounded-xl w-full h-auto object-cover" />
        ))}
      </div>
    </section>
  );
}
