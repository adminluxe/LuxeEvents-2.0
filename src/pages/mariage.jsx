import React from 'react';
import { Helmet } from 'react-helmet-async';

export default function mariage() {
  return (
    <>
      <Helmet>
        <title>LuxeEvents – Mariages de Prestige</title>
        <meta name="description" content="Vivez le mariage de vos rêves avec LuxeEvents, dans un univers de luxe et d’émotion." />
        <meta property="og:title" content="LuxeEvents – Mariages de Prestige" />
        <meta property="og:image" content="/og_default.jpg" />
      </Helmet>

      {/* contenu de la page ici */}
    </>
  );
}
