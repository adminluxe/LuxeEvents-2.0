// LuxeEvents • ServicesSection — version safe (idx défini, clés stables)
import React from "react";
import * as ServicesData from "../data/services.luxe.js";

// Accepte à la fois export default et export nommé { services }
const SERVICES = Array.isArray(ServicesData?.default)
  ? ServicesData.default
  : Array.isArray(ServicesData?.services)
  ? ServicesData.services
  : [];

export default function ServicesSection() {
  if (!Array.isArray(SERVICES) || SERVICES.length === 0) {
    return (
      <section id="services" className="py-16 md:py-24 bg-[#0b0b0b] text-white">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl md:text-4xl font-semibold mb-6 section-title text-contrast">
            Nos Services
          </h2>
          <p className="text-white/70">
            Les services seront bientôt affichés. (Aucun élément dans
            <code className="ml-2">services.luxe.js</code>.)
          </p>
        </div>
      </section>
    );
  }

  return (
    <section id="services" className="py-16 md:py-24 bg-[#0b0b0b] text-white">
      <div className="container mx-auto px-4">
        <h2 className="text-3xl md:text-4xl font-semibold mb-10 section-title text-contrast">
          Nos Services
        </h2>

        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 wow-grid">
          {SERVICES.map((svc, idx) => {
            const key =
              svc?.id ??
              `${idx}-${(svc?.title || svc?.name || "service").toString()}`;

            const title = svc?.title || svc?.name || `Service ${idx + 1}`;
            const description = svc?.description || svc?.desc || "";
            const image = svc?.image || svc?.img || null;
            const Icon = svc?.icon || null; // si c'est un composant React

            return (
              <article
                key={key}
                className="group rounded-2xl p-6 bg-white/5 backdrop-blur-sm transition-all duration-300 hover:-translate-y-0.5 hover:bg-white/7 shimmer"
              >
                <div className="flex items-center gap-3 mb-3">
                  {Icon && typeof Icon === "function" ? (
                    <Icon className="w-6 h-6" aria-hidden />
                  ) : (
                    <span className="text-2xl" aria-hidden>
                      {svc?.emoji || "✨"}
                    </span>
                  )}
                  <h3 className="text-xl font-semibold">{title}</h3>
                </div>

                {image && (
                  <div className="rounded-xl overflow-hidden mb-4">
                    <img
                      src={image}
                      alt={title}
                      loading="lazy"
                      className="w-full h-40 object-cover"
                    />
                  </div>
                )}

                {description && (
                  <p className="text-white/80 text-sm leading-relaxed">
                    {description}
                  </p>
                )}
              </article>
            );
          })}
        </div>
      </div>
    </section>
  );
}
