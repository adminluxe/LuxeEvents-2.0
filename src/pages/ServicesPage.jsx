import React from 'react';
import { Helmet } from 'react-helmet-async';

export default function ServicesPage() {
  return (
    <>
      <Helmet>
        <title>LuxeEvents – Nos services d’exception</title>
        <meta name="description" content="Découvrez nos prestations sur-mesure pour faire de votre événement une réussite." />
        <meta property="og:title" content="LuxeEvents – Nos services d’exception" />
        <meta property="og:image" content="/og_default.jpg" />
      </Helmet>

      {/* contenu de la page ici */}
    </>
  );
}
