import React from 'react';
import { Helmet } from 'react-helmet-async';

export default function RequestQuotePage() {
  return (
    <>
      <Helmet>
        <title>LuxeEvents – Formulaire de demande de devis</title>
        <meta name="description" content="Remplissez notre formulaire et recevez une proposition personnalisée pour votre événement." />
        <meta property="og:title" content="LuxeEvents – Formulaire de demande de devis" />
        <meta property="og:image" content="/og_default.jpg" />
      </Helmet>

      {/* contenu de la page ici */}
    </>
  );
}
