import { Helmet } from "react-helmet-async";
import React from "react";

export default function Legal() {
  return (
<>      <Helmet>        <title:LuxeEvents – Mentions Légales</title>        <meta name="description" content="Page LuxeEvents – Mentions Légales – LuxeEvents" />        <meta property="og:title" content="LuxeEvents – Mentions Légales" />        <meta property="og:image" content="/og_default.jpg" />      </Helmet>
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
