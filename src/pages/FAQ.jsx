import React from "react";
import SeoHead from "../components/SeoHead.jsx";
import { SchemaFAQ } from "../components/SchemaSite.jsx";

const qa = [
  {
    q: "Intervenez-vous uniquement à Paris ?",
    a: "Notre équipe est basée à Paris et intervient en France et à l’international selon vos besoins."
  },
  {
    q: "Quelle est votre spécialité ?",
    a: "Mariages, événements privés et corporate haut de gamme, avec un soin particulier pour le design, la logistique et l’expérience invités."
  },
  {
    q: "Proposez-vous des prestations sur mesure ?",
    a: "Oui, chaque projet est conçu sur-mesure après un échange découverte pour comprendre vos attentes et votre budget."
  },
  {
    q: "Combien de temps à l’avance faut-il réserver ?",
    a: "Idéalement 3 à 6 mois pour un événement privé, 6 à 12 mois pour un mariage. Nous faisons aussi du ‘short notice’ selon disponibilité."
  },
  {
    q: "Travaillez-vous avec des lieux/partenaires spécifiques ?",
    a: "Nous disposons d’un réseau de partenaires vérifiés (lieux, traiteurs, technique, artistes) et recherchons aussi des pépites adaptées à votre brief."
  },
  {
    q: "Comment obtenir un devis ?",
    a: "Rendez-vous sur la page Devis pour nous décrire votre projet. Nous revenons rapidement avec une proposition personnalisée."
  }
];

export default function FAQ() {
  return (
    <main className="min-h-screen bg-[#0b0b0b] text-white">
      <SeoHead
        title="FAQ – LuxeEvents"
        description="Questions fréquentes sur nos prestations événements haut de gamme – Paris & international."
        canonical="https://luxeevents.me/faq"
      />
      <section className="max-w-3xl mx-auto px-4 py-16">
        <h1 className="text-3xl md:text-4xl font-serif mb-8">FAQ</h1>
        <div className="space-y-4">
          {qa.map(({ q, a }, i) => (
            <details key={i} className="bg-white/[0.04] rounded-xl p-4">
              <summary className="cursor-pointer text-lg font-medium">{q}</summary>
              <p className="mt-2 text-white/80">{a}</p>
            </details>
          ))}
        </div>
      </section>
      <SchemaFAQ qa={qa} />
    </main>
  );
}
