"use client";


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
      <RealisationsSection />
      <Testimonials />
        <QuoteForm />
        <MapSection />
        <FooterLuxe />
      </Layout>
    </>
  );
}
