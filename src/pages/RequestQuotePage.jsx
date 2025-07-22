import { Helmet } from "react-helmet-async";
import Layout from "@/layouts/Layout";
import React from 'react';

export default function RequestQuotePage() {
  return (
<>      <Helmet>        <title:LuxeEvents – Demande de Devis</title>        <meta name="description" content="Page LuxeEvents – Demande de Devis – LuxeEvents" />        <meta property="og:title" content="LuxeEvents – Demande de Devis" />        <meta property="og:image" content="/og_default.jpg" />      </Helmet>
    <Layout>
      <div className="p-8 text-center">
        <h1 className="text-3xl sm:text-4xl font-bold text-center text-yellow-600 hover:scale-105 transition">
          {/* Texte du titre */}
        </h1>
        <p className="mt-4 text-gray-700">
          Nous reviendrons vers vous très rapidement avec une offre adaptée.
        </p>
      </div>
    </Layout>
  );
}
