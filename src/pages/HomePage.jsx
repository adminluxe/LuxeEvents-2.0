import React from 'react';
import { Helmet } from 'react-helmet-async';

export default function HomePage() {
  return (
    <>
      <Helmet>
        <title>LuxeEvents – Sublimez votre événement</title>
        <meta name="description" content="Page d'accueil immersive de LuxeEvents – Événements haut de gamme." />
        <meta property="og:title" content="LuxeEvents – Sublimez votre événement" />
        <meta property="og:image" content="/og_default.jpg" />
      </Helmet>

      {/* contenu de la page ici */}
    </>
  );
}
