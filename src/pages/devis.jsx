import React from 'react';
import { Helmet } from 'react-helmet-async';

export default function devis() {
  return (
    <>
      <Helmet>
        <title>LuxeEvents – Demandez votre devis personnalisé</title>
        <meta name="description" content="Un événement sur-mesure commence ici. Demandez votre devis gratuitement." />
        <meta property="og:title" content="LuxeEvents – Demandez votre devis personnalisé" />
        <meta property="og:image" content="/og_default.jpg" />
      </Helmet>

      {/* contenu de la page ici */}
    </>
  );
}
