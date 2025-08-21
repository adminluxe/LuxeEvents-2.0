import React from "react";

export default function TrustBadges(){
  return (
    <section aria-labelledby="titre-trust" className="py-10">
      <div className="container mx-auto px-4">
        <h2 id="titre-trust" className="sr-only">Ils nous font confiance</h2>
        <ul className="grid grid-cols-2 sm:grid-cols-4 gap-4 text-center text-white/80">
          <li className="p-4 rounded-xl bg-white/5 border border-white/10">Google ★ 4.9/5</li>
          <li className="p-4 rounded-xl bg-white/5 border border-white/10">Trustpilot ★ 4.8/5</li>
          <li className="p-4 rounded-xl bg-white/5 border border-white/10">120+ clients</li>
          <li className="p-4 rounded-xl bg-white/5 border border-white/10">10 ans d’expérience</li>
        </ul>
      </div>
    </section>
  );
}
