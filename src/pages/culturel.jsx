import React from 'react';
import { Helmet } from 'react-helmet-async';

export default function culturel() {
  return (
    <>
      <Helmet>
        <title>LuxeEvents – Événements culturels d’exception</title>
        <meta name="description" content="Sublimez l’art, la mode ou le patrimoine grâce à une mise en scène innovante et immersive." />
        <meta property="og:title" content="LuxeEvents – Événements culturels d’exception" />
        <meta property="og:image" content="/og_default.jpg" />
      </Helmet>

      {/* contenu de la page ici */}
    </>
  );
}
