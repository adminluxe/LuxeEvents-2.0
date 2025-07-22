import React from 'react';
import { Helmet } from 'react-helmet-async';

export default function MediaPage() {
  return (
    <>
      <Helmet>
        <title>LuxeEvents – Galerie photos et vidéos</title>
        <meta name="description" content="Plongez dans l’univers visuel de LuxeEvents à travers nos plus beaux événements." />
        <meta property="og:title" content="LuxeEvents – Galerie photos et vidéos" />
        <meta property="og:image" content="/og_default.jpg" />
      </Helmet>

      {/* contenu de la page ici */}
    </>
  );
}
