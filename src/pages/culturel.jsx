import { Helmet } from "react-helmet";
import FadeUpWrapper from "../components/FadeUpWrapper";

export default function CulturelPage() {
  return (
  <>
    <Helmet>
      <title>LuxeEvents – Événements culturels d’exception</title>
      <meta name="description" content="Sublimez l’art, la mode ou le patrimoine grâce à une mise en scène innovante et immersive." />
      <meta property="og:title" content="LuxeEvents – Événements culturels d’exception" />
      <meta property="og:image" content="/og_default.jpg" />
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
  </>
}
