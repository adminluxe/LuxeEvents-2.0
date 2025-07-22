import { Helmet } from "react-helmet";
import FadeUpWrapper from "../components/FadeUpWrapper";

export default function CorporatePage() {
  return (
  <>
    <Helmet>
      <title>LuxeEvents – Événements d’entreprise haut de gamme</title>
      <meta name="description" content="Séminaires, galas, lancements : impressionnez vos clients avec une organisation irréprochable." />
      <meta property="og:title" content="LuxeEvents – Événements d’entreprise haut de gamme" />
      <meta property="og:image" content="/og_default.jpg" />
    </Helmet>
      <section className="py-24 px-4 text-center">
        <h1 className="text-4xl md:text-6xl font-bold text-gold mb-6">
          Événements Corporate
        </h1>
        <p className="text-lg max-w-3xl mx-auto">
          LuxeEvents conçoit des expériences professionnelles immersives pour sublimer
          votre image de marque, renforcer la cohésion et impressionner vos partenaires
          dans un cadre d’exception.
        </p>
      </section>
    </FadeUpWrapper>
  );
  </>
}
