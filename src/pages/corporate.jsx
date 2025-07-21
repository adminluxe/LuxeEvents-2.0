import { Helmet } from "react-helmet";
import FadeUpWrapper from "../components/FadeUpWrapper";

export default function CorporatePage() {
  return (
    <FadeUpWrapper>
      <Helmet>
        <title>Événements d'Entreprise – LuxeEvents</title>
        <meta
          name="description"
          content="Conférences, lancements de produits, team building... Offrez à vos collaborateurs une expérience élégante et inspirante."
        />
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
}
