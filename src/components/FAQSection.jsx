import React from "react";
import { SchemaFAQ } from "./SchemaSite.jsx";

const QA = [
  {
    q: "Quels types d’événements organisez-vous ?",
    a: "Mariages, événements privés (anniversaires, fêtes) et corporate (galas, séminaires) avec un accompagnement premium.",
  },
  {
    q: "Intervenez-vous en dehors de la Belgique ?",
    a: "Oui, sur demande. Nous couvrons principalement la Belgique, avec des prestations possibles à l’international.",
  },
  {
    q: "Proposez-vous un devis gratuit ?",
    a: "Bien sûr. Un premier échange nous permet d’estimer le budget et le scope avant une proposition sur-mesure.",
  },
];

export default function FAQSection(){
  return (
    <section className="container mx-auto px-4 py-12">
      <h2 className="text-2xl md:text-3xl font-semibold mb-6">FAQ</h2>
      <div className="space-y-3">
        {QA.map((item, i) => (
          <details key={i} className="group rounded-xl border border-white/10 bg-white/5 p-4 open:bg-white/10">
            <summary className="cursor-pointer font-medium">{item.q}</summary>
            <p className="mt-2 text-white/80">{item.a}</p>
          </details>
        ))}
      </div>
      <SchemaFAQ qa={QA} />
    </section>
  );
}
