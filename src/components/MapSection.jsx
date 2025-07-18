import React from "react";

export default function MapSection() {
  return (
    <section className="py-16 bg-black text-white text-center">
      <h2 className="text-4xl font-bold text-[#d4af37] mb-8">Nous trouver</h2>
      <div className="max-w-4xl mx-auto">
        <iframe
          title="Adresse LuxeEvents"
          src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2520.972787845712!2d4.351710315746321!3d50.85033937953452!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x47c3c3804a91a871%3A0x4eb8f6f07cd02411!2sBruxelles!5e0!3m2!1sfr!2sbe!4v1687816952168!5m2!1sfr!2sbe"
          width="100%"
          height="400"
          className="rounded-lg border border-[#d4af37]"
          allowFullScreen
          loading="lazy"
        ></iframe>
      </div>
    </section>
  );
}
