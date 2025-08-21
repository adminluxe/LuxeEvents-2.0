import React from "react";
import SchemaOrg from "./SchemaOrg.jsx";

// Accueil : Organization + Website + Fil d'Ariane
export function SchemaHome() {
  const data = [
    {
      "@context": "https://schema.org",
      "@type": "Organization",
      "name": "LuxeEvents",
      "url": "https://luxeevents.me/",
      "logo": "https://luxeevents.me/logo_gold_black.png",
      "description": "Le Luxe à la portée de tous… Pour des expériences inoubliables !",
      "address": {
        "@type": "PostalAddress",
        "addressLocality": "Paris",
        "addressCountry": "FR"
      },
      "areaServed": "Worldwide",
      "sameAs": []
    },
    {
      "@context": "https://schema.org",
      "@type": "WebSite",
      "name": "LuxeEvents",
      "url": "https://luxeevents.me/",
      "inLanguage": "fr-FR",
      "potentialAction": {
        "@type": "SearchAction",
        "target": "https://luxeevents.me/?s={search_term_string}",
        "query-input": "required name=search_term_string"
      }
    },
    {
      "@context": "https://schema.org",
      "@type": "BreadcrumbList",
      "itemListElement": [
        { "@type": "ListItem", "position": 1, "name": "Accueil", "item": "https://luxeevents.me/" }
      ]
    }
  ];
  return <SchemaOrg json={data} />;
}

// Réalisations : fil d'Ariane
export function SchemaRealisations() {
  const data = [{
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
      { "@type": "ListItem", "position": 1, "name": "Accueil", "item": "https://luxeevents.me/" },
      { "@type": "ListItem", "position": 2, "name": "Réalisations", "item": "https://luxeevents.me/realisations" }
    ]
  }];
  return <SchemaOrg json={data} />;
}

// FAQ : JSON-LD à partir d'un tableau de Q/R
export function SchemaFAQ({ qa = [] }) {
  const json = {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": qa.map(({ q, a }) => ({
      "@type": "Question",
      "name": q,
      "acceptedAnswer": { "@type": "Answer", "text": a }
    }))
  };
  return <SchemaOrg json={json} />;
}
