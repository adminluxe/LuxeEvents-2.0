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
        <title>LuxeEvents – Événements haut de gamme, le luxe à la portée de tous!</title>
        <meta
          name="description"
          content="Organisation d’événements élégants à Bruxelles – mariages, soirées, corporate. Devis gratuit."
        />
        <meta property="og:title" content="LuxeEvents – Le luxe à la portée de tous" />
        <meta property="og:image" content="/media/images/luxeevents-bg-hero.webp" />
      </Helmet>

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
}
