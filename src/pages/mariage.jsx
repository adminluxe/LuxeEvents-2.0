import { Helmet } from "react-helmet";
import FadeUpWrapper from "../components/FadeUpWrapper";

export default function MariagePage() {
  return (
  <>
    <Helmet>
      <title>LuxeEvents – Mariages de Prestige</title>
      <meta name="description" content="Vivez le mariage de vos rêves avec LuxeEvents, dans un univers de luxe et d’émotion." />
      <meta property="og:title" content="LuxeEvents – Mariages de Prestige" />
      <meta property="og:image" content="/og_default.jpg" />
    </Helmet>
      <section className="py-24 px-4 text-center">
        <h1 className="text-4xl md:text-6xl font-bold text-gold mb-6">
          Mariages d'Exception
        </h1>
        <p className="text-lg max-w-3xl mx-auto">
          Chaque mariage est une histoire unique. LuxeEvents sublime votre union
          avec une organisation raffinée, sur mesure, dans des lieux d’exception.
          Confiez-nous vos rêves, nous les orchestrons avec magie.
        </p>
      </section>
    </FadeUpWrapper>
  );
  </>
}
