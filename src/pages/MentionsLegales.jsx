import React from "react";
import SeoHead from "../components/SeoHead.jsx";
export default function MentionsLegales(){
  return (
    <main className="min-h-screen bg-[#0b0b0b] text-white pt-20">
      <SeoHead title="Mentions légales – LuxeEvents" canonical="https://luxeevents.me/mentions-legales" />
      <section className="container mx-auto px-4 py-10">
        <h1 className="section-title text-3xl md:text-4xl mb-6">Mentions légales</h1>
        <p className="muted-contrast">Raison sociale, hébergeur, contact, etc. (à compléter).</p>
      </section>
    </main>
  );
}
