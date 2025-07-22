import { Helmet } from "react-helmet-async";
import { Helmet } from "react-helmet";
import FadeUpWrapper from "../components/FadeUpWrapper";

export default function CulturelPage() {
  return (
<>      <Helmet>        <title:LuxeEvents – Culturel</title>        <meta name="description" content="Page LuxeEvents – Culturel – LuxeEvents" />        <meta property="og:title" content="LuxeEvents – Culturel" />        <meta property="og:image" content="/og_default.jpg" />      </Helmet>
    <FadeUpWrapper>
      <Helmet>
        <title>Événements Culturels – LuxeEvents</title>
        <meta
          name="description"
          content="Concerts, expositions, festivals... Une organisation signée LuxeEvents pour un rayonnement artistique unique."
        />
      </Helmet>
      <section className="py-24 px-4 text-center">
        <h1 className="text-4xl md:text-6xl font-bold text-gold mb-6">
          Événements Culturels
        </h1>
        <p className="text-lg max-w-3xl mx-auto">
          L’art, la musique, la scène... LuxeEvents déploie ses talents pour vous
          offrir des événements culturels d’envergure, pensés pour émerveiller et inspirer.
        </p>
      </section>
    </FadeUpWrapper>
  );
}
