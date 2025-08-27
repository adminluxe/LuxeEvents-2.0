import { useTranslation } from "react-i18next";
import { motion } from "framer-motion";
import Map from "@/components/Map";
import SeoDefaults from "@/seo/SeoDefaults";
export default function Home(){
  const { t } = useTranslation();
  const features=t("home.features",{returnObjects:true,defaultValue:[]})||[];
  const services=t("home.services",{returnObjects:true,defaultValue:[]})||[];
  return (
    <main className="pt-24 pb-16 space-y-16 dark:bg-[#0a0a0a]">
      <SeoDefaults title="Accueil" path="/" />
      <section className="max-w-6xl mx-auto px-4 text-center">
        <h1 className="text-4xl md:text-6xl font-extrabold tracking-tight text-amber-400">Le luxe à la portée de tous – Une expérience inoubliable!</h1>
        <p className="mt-4 text-neutral-300">{t("home.subtitle")}</p>
        <div className="mt-8"><a href="#services" className="inline-block px-6 py-3 rounded-full bg-amber-500 text-black font-semibold hover:scale-105 transition">{t("home.cta")}</a></div>
      </section>
      {Array.isArray(features)&&features.length>0&&(
        <section className="max-w-6xl mx-auto px-4 grid md:grid-cols-3 gap-6">
          {features.map((f,i)=>(
            <motion.div key={i} initial={{opacity:0,y:20}} whileInView={{opacity:1,y:0}} viewport={{once:true}} className="p-6 rounded-2xl border border-amber-500/30 bg-black/30">
              <h3 className="text-lg font-semibold text-amber-300">{f.title}</h3>
              <p className="text-sm text-neutral-300 mt-1">{f.desc}</p>
            </motion.div>
          ))}
        </section>
      )}
      <section id="services" className="max-w-6xl mx-auto px-4">
        <h2 className="text-2xl font-bold text-amber-400 mb-6">{t("home.servicesTitle")}</h2>
        <div className="grid md:grid-cols-3 gap-6">
          {Array.isArray(services)&&services.length>0?services.map((s,i)=>(
            <div key={i} className="p-6 rounded-2xl border border-amber-500/30 bg-black/30">
              <h3 className="text-lg font-semibold text-amber-300">{s.title}</h3>
              <p className="text-sm text-neutral-300 mt-1">{s.desc}</p>
            </div>
          )):<p className="text-neutral-400">Contenu en préparation.</p>}
        </div>
      </section>
      <section className="max-w-6xl mx-auto px-4">
        <h2 className="text-2xl font-bold text-amber-400 mb-4">{t("home.mapTitle")}</h2>
        <Map/>
      </section>
    </main>
  );
}
