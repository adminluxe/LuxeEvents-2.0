import LanguageSwitcher from "./components/LanguageSwitcher";
import ThemeToggle from "./components/ThemeToggle";
import ServicesSection from "./components/ServicesSection";
import GallerySection from "./components/GallerySection";
import Footer from "./components/Footer";
import { useLang } from "./i18n/LangContext";
export default function App(){
  const { lang } = useLang();
  const t = (fr,en)=> lang==="fr"?fr:en;
  return (
    <>
      <header className="container mx-auto py-6 flex items-center justify-between">
        <a href="/" className="font-serif text-2xl">LuxeEvents</a>
        <nav className="hidden md:flex gap-6">
          <a href="#services">{t("Services","Services")}</a>
          <a href="#realisations">{t("Réalisations","Showcase")}</a>
          <a href="#devis">{t("Devis","Quote")}</a>
        </nav>
        <div className="flex items-center gap-2">
          <LanguageSwitcher />
          <ThemeToggle />
        </div>
      </header>

      <main>
        <section className="container mx-auto py-20">
          <h1 className="text-4xl md:text-6xl font-serif mb-4">
            {t("Événements haut de gamme, élégants et mémorables.","Elegant, memorable, high-end events.")}
          </h1>
          <p className="opacity-80 mb-8">{t("Luxe, Excellence, Innovation.","Luxury, Excellence, Innovation.")}</p>
          <a className="inline-block px-6 py-3 rounded-full bg-black text-white" href="#devis">
            {t("Voir nos réalisations","See our work")}
          </a>
        </section>

        <ServicesSection />
        <GallerySection />

        <section id="devis" className="container mx-auto py-16">
          <h2 className="text-3xl font-serif mb-6">{t("Demander un devis","Request a quote")}</h2>
          <form className="grid md:grid-cols-2 gap-4">
            <input className="border rounded-lg p-3" placeholder={t("Nom complet","Full name")} required />
            <input className="border rounded-lg p-3" placeholder="Email" type="email" required />
            <input className="border rounded-lg p-3 md:col-span-2" placeholder={t("Date & ville","Date & city")} />
            <textarea className="border rounded-lg p-3 md:col-span-2" rows="5" placeholder={t("Votre projet","Your project")}></textarea>
            <button className="px-6 py-3 rounded-full bg-black text-white md:col-span-2">{t("Envoyer","Send")}</button>
          </form>
        </section>
      </main>

      <Footer />
    </>
  );
}
