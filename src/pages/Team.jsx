import React from 'react';
import { Helmet } from 'react-helmet';
export default function Team() {
  return (
    <>
      <Helmet>
        <title>Équipe | LuxeEvents</title>
        <meta name="description" content="Rencontrez les artisans de vos événements : l’équipe passionnée de LuxeEvents." />
      </Helmet>
      <main className="prose mx-auto p-8">
        <h1>Notre Équipe</h1>
        <ul>
          <li>🎩 Alice, Directrice Artistique</li>
          <li>📊 Bob, Expert Analytics</li>
          <li>🌐 Chloé, Responsable International</li>
        </ul>
      </main>
    </>
  );
}
