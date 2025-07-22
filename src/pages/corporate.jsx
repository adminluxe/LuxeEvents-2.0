import React from 'react';
import { Helmet } from 'react-helmet-async';

export default function corporate() {
  return (
    <>
      <Helmet>
        <title>LuxeEvents – Événements d’entreprise haut de gamme</title>
        <meta name="description" content="Séminaires, galas, lancements : impressionnez vos clients avec une organisation irréprochable." />
        <meta property="og:title" content="LuxeEvents – Événements d’entreprise haut de gamme" />
        <meta property="og:image" content="/og_default.jpg" />
      </Helmet>

      {/* contenu de la page ici */}
    </>
  );
}
