import { Helmet } from "react-helmet-async";
import { Helmet } from "react-helmet";
import FadeUpWrapper from "../components/FadeUpWrapper";

export default function MariagePage() {
  return (
<>      <Helmet>        <title:LuxeEvents – Mariage</title>        <meta name="description" content="Page LuxeEvents – Mariage – LuxeEvents" />        <meta property="og:title" content="LuxeEvents – Mariage" />        <meta property="og:image" content="/og_default.jpg" />      </Helmet>
    <FadeUpWrapper>
      <Helmet>
        <title>Mariages d'Exception – LuxeEvents</title>
        <meta
          name="description"
          content="Célébrez l'amour avec élégance. Organisation de mariages haut de gamme partout en Europe."
        />
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
}
