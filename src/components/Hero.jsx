import React from "react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

export default function Hero() {
  const { t } = useTranslation();
  return (
    <section className="relative h-screen bg-cover bg-center" style={{backgroundImage: "url('/assets/hero-bg.jpg')"}}>
      <div className="absolute inset-0 bg-black bg-opacity-50" />
      <motion.div
        className="relative z-10 flex flex-col items-center justify-center h-full text-center text-white px-4"
        initial={{ opacity: 0, y: 50 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 1 }}
      >
        <h1 className="text-5xl font-serif mb-4">{t("hero.title")}</h1>
        <p className="text-xl max-w-2xl mb-8">{t("hero.subtitle")}</p>
        <Link to="/events" className="px-6 py-3 bg-gold-500 hover:bg-gold-600 rounded-lg text-lg">
          {t("hero.cta")}
        </Link>
      </motion.div>
    </section>
  );
}
