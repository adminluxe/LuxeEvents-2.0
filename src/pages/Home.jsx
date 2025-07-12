import Hero from "@/components/Hero";
import FeatureList from "@/components/FeatureList";
import Testimonial from "@/components/Testimonial";
import Footer from "@/components/Footer";

export default function Home() {
  return (
    <>
      <Hero
        title={["Le luxe n’est plus", "une question de", "moyens, mais", "d’expérience."]}
        subtitle="Chez LuxeEvents, nous orchestrons des moments uniques, élégants, et accessibles."
        cta={{ text: "Demandez un devis", href: "/contact" }}
      />
      <FeatureList
        items={[
          { title: "Organisation complète", text: "De la conception à la réalisation, on gère tout." },
          { title: "Coordination Jour J",    text: "Pour que vous profitiez sans souci." },
          { title: "Détails personnalisés",  text: "Chaque événement est unique, comme vous." },
          { title: "Luxe accessible",       text: "Élégance et raffinement à prix juste." },
        ]}
      />
      <Testimonial
        quote="LuxeEvents a transformé notre mariage en un conte de fées moderne. Professionnalisme et créativité à l’état pur !"
        author="Julie & Marc"
      />
      <Footer />
    </>
  );
}
