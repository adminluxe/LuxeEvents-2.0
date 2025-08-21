import React from "react";
import SeoHead from "../components/SeoHead.jsx";
export default function PolitiqueConfidentialite(){
  return (
    <main className="min-h-screen bg-[#0b0b0b] text-white pt-20">
      <SeoHead title="Politique de confidentialité – LuxeEvents" canonical="https://luxeevents.me/politique-confidentialite" />
      <section className="container mx-auto px-4 py-10">
        <h1 className="section-title text-3xl md:text-4xl mb-6">Politique de confidentialité</h1>
        <p className="muted-contrast">Conforme RGPD (finaliser texte & DPO si applicable).</p>
      </section>
    </main>
  );
}
