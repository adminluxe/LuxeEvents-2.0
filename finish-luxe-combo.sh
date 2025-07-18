#!/bin/bash

echo "✨ Injection des composants finaux LuxeEvents..."

mkdir -p src/components src/pages

# ✅ 1. Testimonials.jsx
cat << 'TESTIMONIALS' > src/components/Testimonials.jsx
import React from "react";
import FadeUpWrapper from "@/components/FadeUpWrapper";

const testimonials = [
  {
    name: "Sophie D.",
    feedback: "Un mariage magique, organisé de main de maître. LuxeEvents, c'est du haut niveau.",
    location: "Bruxelles",
  },
  {
    name: "Amine B.",
    feedback: "Anniversaire inoubliable. Équipe sérieuse, déco sublime. Merci !",
    location: "Etterbeek",
  },
  {
    name: "Léa M.",
    feedback: "Notre événement pro a bluffé tous les invités. Bravo pour l'élégance.",
    location: "Uccle",
  },
];

export default function Testimonials() {
  return (
    <section id="testimonials" className="py-16 bg-black/30 backdrop-blur-md text-white text-center">
      <FadeUpWrapper>
        <h2 className="text-4xl font-bold text-[#d4af37] mb-8">Témoignages</h2>
      </FadeUpWrapper>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-6xl mx-auto px-6">
        {testimonials.map((t, i) => (
          <FadeUpWrapper delay={i * 0.2} key={i}>
            <div className="p-6 bg-white/10 border border-[#d4af37] rounded-xl shadow-lg">
              <p className="italic mb-4">“{t.feedback}”</p>
              <p className="font-semibold">{t.name}</p>
              <p className="text-sm text-white/60">{t.location}</p>
            </div>
          </FadeUpWrapper>
        ))}
      </div>
    </section>
  );
}
TESTIMONIALS

# ✅ 2. QuoteForm.jsx
cat << 'QUOTEFORM' > src/components/QuoteForm.jsx
import React from "react";
import FadeUpWrapper from "@/components/FadeUpWrapper";

export default function QuoteForm() {
  return (
    <section id="quote" className="py-16 bg-white text-black text-center">
      <FadeUpWrapper>
        <h2 className="text-4xl font-bold text-[#d4af37] mb-8">Demandez un devis</h2>
      </FadeUpWrapper>
      <form
        className="max-w-2xl mx-auto grid gap-4 text-left"
        onSubmit={(e) => {
          e.preventDefault();
          alert("Merci ! Nous vous recontactons sous 24h.");
        }}
      >
        <input className="p-3 border border-gray-300 rounded-md" placeholder="Nom complet" required />
        <input className="p-3 border border-gray-300 rounded-md" placeholder="Email" type="email" required />
        <input className="p-3 border border-gray-300 rounded-md" placeholder="Téléphone" required />
        <input className="p-3 border border-gray-300 rounded-md" placeholder="Type d'événement (ex : mariage)" />
        <textarea className="p-3 border border-gray-300 rounded-md" placeholder="Détails..." rows={4}></textarea>
        <button type="submit" className="bg-[#d4af37] text-white py-3 px-6 rounded-xl font-semibold hover:opacity-90">
          Envoyer ma demande
        </button>
      </form>
    </section>
  );
}
QUOTEFORM

# ✅ 3. MapSection.jsx
cat << 'MAPSECTION' > src/components/MapSection.jsx
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
MAPSECTION

# ✅ 4. Legal.jsx
cat << 'LEGALPAGE' > src/pages/Legal.jsx
import React from "react";

export default function Legal() {
  return (
    <div className="min-h-screen px-6 py-24 max-w-3xl mx-auto text-white">
      <h1 className="text-3xl font-bold text-[#d4af37] mb-6">Mentions légales & Politique de confidentialité</h1>
      <p className="mb-4 text-white/80">
        LuxeEvents – Organisation d’événements élégants et haut de gamme. Siège à Bruxelles. Responsable de publication :
        Tonton Luxe. Données personnelles traitées uniquement dans le cadre de votre demande de devis. Aucune
        revente, ni publicité tierce.
      </p>
      <p className="text-white/60">Dernière mise à jour : Juillet 2025</p>
    </div>
  );
}
LEGALPAGE

# ✅ 5. FooterLuxe.jsx
cat << 'FOOTERLUXE' > src/components/FooterLuxe.jsx
import React from "react";
import { Link } from "react-router-dom";

export default function FooterLuxe() {
  return (
    <footer className="bg-black text-white text-sm py-6 px-4 text-center border-t border-white/10">
      <div className="max-w-4xl mx-auto flex flex-col md:flex-row justify-between items-center gap-4">
        <p>&copy; {new Date().getFullYear()} LuxeEvents – Tous droits réservés.</p>
        <div className="flex gap-4">
          <Link to="/legal" className="hover:text-[#d4af37]">Mentions légales</Link>
          <a href="mailto:contact@luxeevents.me" className="hover:text-[#d4af37]">contact@luxeevents.me</a>
        </div>
      </div>
    </footer>
  );
}
FOOTERLUXE

# ✅ Patch HomePage.jsx pour ajouter les imports et composants
echo "📌 Mise à jour de HomePage.jsx..."
sed -i '/import Layout/a\
import Testimonials from "@/components/Testimonials";\
import QuoteForm from "@/components/QuoteForm";\
import MapSection from "@/components/MapSection";\
import FooterLuxe from "@/components/FooterLuxe";' src/pages/HomePage.jsx

sed -i '/<\/Layout>/i\
        <Testimonials />\
        <QuoteForm />\
        <MapSection />\
        <FooterLuxe />' src/pages/HomePage.jsx

echo "✅ Combo final injecté. Tu peux commit + deploy !"
