import React from "react";
import { testimonials } from "../data/testimonials";
import { Swiper, SwiperSlide } from "swiper/react";
import "swiper/css";

export default function TestimonialsCarousel({ lang = "fr" }) {
  const t = (o) => (o?.[lang] ?? o?.fr ?? "");
  return (
    <section aria-labelledby="titre-temoignages" id="trust" className="py-12 sm:py-20">
      <div className="container mx-auto px-4">
        <header className="mb-8 sm:mb-12">
          <h2 id="titre-temoignages" className="text-3xl sm:text-4xl font-serif text-white section-title text-contrast">Ils nous font confiance
            {lang === "en" ? "They trust us" : "Ils nous font confiance"}
          </h2>
          <p className="text-white/70 mt-2">
            {lang === "en"
              ? "Selected testimonials from our clients and partners."
              : "Quelques témoignages de nos clients et partenaires."}
          </p>
        </header>
        <Swiper spaceBetween={24} slidesPerView={1} breakpoints={{768:{slidesPerView:2},1024:{slidesPerView:3}}}>
          {testimonials.map((item, idx) => (
            <SwiperSlide key={idx}>
              <article className="rounded-2xl bg-white/5 ring-1 ring-white/10 p-5 h-full flex flex-col gap-4">
                <div className="flex items-center gap-3">
                  <img
                    src={item.thumb || "/images/og-luxeevents.jpg"}
                    alt={item.name}
                    className="w-12 h-12 rounded-full object-cover ring-1 ring-white/20"
                    loading="lazy"
                  />
                  <div>
                    <p className="text-white font-medium">{item.name}</p>
                    <p className="text-white/60 text-sm">{t(item.role)}</p>
                  </div>
                </div>
                <p className="text-white/80 leading-relaxed">“{t(item.quote)}”</p>
              </article>
            </SwiperSlide>
          ))}
        </Swiper>
      </div>
    </section>
  );
}
