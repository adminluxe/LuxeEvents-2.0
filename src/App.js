import React from "react";
import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";
import { useTranslation } from "react-i18next";

import Hero from "./components/Hero";
import Services from "./components/Services";
import EventSlider from "./components/EventSlider";
import Footer from "./components/Footer";
import LanguageSwitcher from "./components/LanguageSwitcher";

import "./i18n";
import "./App.css";

const Nav = () => {
  const { t } = useTranslation();
  return (
    <nav className="flex justify-between p-4 bg-gray-900 text-white">
      <Link to="/" className="font-bold text-xl">luxeEvents</Link>
      <div className="flex items-center space-x-4">
        <Link to="/events" className="hover:underline">{t("events")}</Link>
        <LanguageSwitcher />
      </div>
    </nav>
  );
};

export default function App() {
  return (
    <Router>
      <Nav />
      <main className="mt-4 space-y-16">
        <Hero />
        <Services />
        <EventSlider />
      </main>
      <Footer />
    </Router>
  );
}
