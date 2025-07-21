import { Helmet } from "react-helmet";
import QuoteForm from "../components/QuoteForm";
import FadeUpWrapper from "../components/FadeUpWrapper";

export default function DevisPage() {
  return (
    <FadeUpWrapper>
      <Helmet>
        <title>Demande de Devis – LuxeEvents</title>
        <meta
          name="description"
          content="Un événement d'exception commence ici. Contactez-nous pour un devis sur-mesure."
        />
      </Helmet>
      <QuoteForm />
    </FadeUpWrapper>
  );
}
