import React from 'react';
import { Helmet } from 'react-helmet';  // Correct importation de react-helmet

const DevisPage = () => {
  return (
  <>
    <Helmet>
      <title>LuxeEvents – Demandez votre devis personnalisé</title>
      <meta name="description" content="Un événement sur-mesure commence ici. Demandez votre devis gratuitement." />
      <meta property="og:title" content="LuxeEvents – Demandez votre devis personnalisé" />
      <meta property="og:image" content="/og_default.jpg" />
    </Helmet>

      <h1 className="text-3xl font-semibold text-center text-yellow-600">Demande de Devis</h1>
      <p className="text-center mt-4 text-gray-700">
        Merci de remplir ce formulaire pour obtenir un devis personnalisé.
      </p>
    </div>
  );
};

  </>
export default DevisPage;
