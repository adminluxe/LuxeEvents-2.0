import React from 'react';
import { Helmet } from 'react-helmet';  // Correct importation de react-helmet

const DevisPage = () => {
  return (
    <div>
      <Helmet>
        <title>Page de Devis</title>
        <meta name="description" content="Demande de devis pour LuxeEvents" />
      </Helmet>

      <h1 className="text-3xl font-semibold text-center text-yellow-600">Demande de Devis</h1>
      <p className="text-center mt-4 text-gray-700">
        Merci de remplir ce formulaire pour obtenir un devis personnalisé.
      </p>
    </div>
  );
};

export default DevisPage;
