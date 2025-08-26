import { services } from "../data/services.luxe";
import { useLang } from "../i18n/LangContext";
export default function ServicesSection() {
  const { lang } = useLang();
  const t = (fr, en) => (lang === "fr" ? fr : en);
  if (!services?.length) {
    return <section id="services" className="container mx-auto py-16">
      <h2 className="text-3xl font-serif mb-6">{t("Nos services", "Our services")}</h2>
      <p className="opacity-70">{t("Les services seront bientôt affichés.", "Services will be displayed shortly.")}</p>
    </section>;
  }
  return (
    <section id="services" className="container mx-auto py-16">
      <h2 className="text-3xl font-serif mb-8">{t("Nos services", "Our services")}</h2>
      <div className="grid md:grid-cols-3 gap-6">
        {services.map(s => (
          <div key={s.id} className="p-6 rounded-2xl border shadow-sm bg-white/40 backdrop-blur">
            <div className="text-2xl mb-3">{s.icon}</div>
            <h3 className="text-xl font-semibold mb-2">{t(s.title_fr, s.title_en)}</h3>
            <p className="opacity-80">{t(s.desc_fr, s.desc_en)}</p>
          </div>
        ))}
      </div>
    </section>
  );
}
