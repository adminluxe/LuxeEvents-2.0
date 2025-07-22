import React from "react";
import { Helmet } from "react-helmet";
import Layout from "@/layouts/Layout";
import HeroSection from "@/components/HeroSection";
import GalleryPreview from "@/components/GalleryPreview";
import ServicesSection from "@/components/ServicesSection";
import Testimonials from "@/components/Testimonials";
import QuoteForm from "@/components/QuoteForm";
import MapSection from "@/components/MapSection";
import FooterLuxe from "@/components/FooterLuxe";

export default function HomePage() {
  return (
  <>
    <Helmet>
      <title>LuxeEvents – Sublimez votre événement</title>
      <meta name="description" content="Page d'accueil immersive de LuxeEvents – Événements haut de gamme." />
      <meta property="og:title" content="LuxeEvents – Sublimez votre événement" />
      <meta property="og:image" content="/og_default.jpg" />
    </Helmet>
    <>\
    <>

      <Layout>
        <HeroSection />
        <GalleryPreview />
        <ServicesSection />
        <Testimonials />
        <QuoteForm />
        <MapSection />
        <FooterLuxe />
      </Layout>
    </>
  );
  </>
}
