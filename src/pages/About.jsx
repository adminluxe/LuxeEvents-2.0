import React from 'react';
import { Helmet } from 'react-helmet';
export default function About() {
  return (
    <>
      <Helmet>
        <title>À propos | LuxeEvents</title>
        <meta name="description" content="Découvrez la vision, la mission et l’histoire de LuxeEvents, votre partenaire pour des événements inoubliables." />
      </Helmet>
      <main className="prose mx-auto p-8">
        <h1>À propos de LuxeEvents</h1>
        <p>Chez LuxeEvents, nous transformons vos rêves en expériences hors du commun…</p>
      </main>
    </>
  );
}
