import React from "react";
import SeoHead from "../components/SeoHead.jsx";
export default function APropos(){
  return (
    <main className="min-h-screen bg-[#0b0b0b] text-white pt-20">
      <SeoHead title="Qui sommes-nous – LuxeEvents" canonical="https://luxeevents.me/a-propos" />
      <section className="container mx-auto px-4 py-10">
        <h1 className="section-title text-3xl md:text-4xl mb-6">Qui sommes-nous</h1>
        <p className="muted-contrast">LuxeEvents est porté par Purple Orchid Group. Notre mission : luxe, excellence, innovation au service d’événements mémorables.</p>
      </section>
    </main>
  );
}
