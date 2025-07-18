import React from "react";
import Layout from "@/layouts/Layout";
import HeroSection from "@/components/HeroSection";
import GalleryPreview from "@/components/GalleryPreview";
import ServicesSection from "@/components/ServicesSection";
import Testimonials from "@/components/Testimonials";
import QuoteForm from "@/components/QuoteForm";
import Footer from "@/components/Footer";

export default function HomePage() {
  return (
    <Layout>
      <HeroSection />
      <GalleryPreview />
      <ServicesSection />
      <Testimonials />
      <QuoteForm />
      <Footer />
    </Layout>
  );
}
