import React from "react";
import "./styles/luxe.css";
import {LangProvider, useLang} from "./i18n/LangContext.jsx";
import ThemeToggle from "./components/ThemeToggle.jsx";
import LangSwitch from "./components/LangSwitch.jsx";
import ServicesSection from "./components/ServicesSection.jsx";
import GallerySection from "./components/GallerySection.jsx";
import ContactSection from "./components/ContactSection.jsx";
import Footer from "./components/Footer.jsx";

function Topbar(){
  const {t} = useLang();
  return (
    <div className="lx-topbar">
      <div className="lx-wrap lx-row" style={{padding:"10px 0"}}>
        <div className="lx-badge">{t("badge")}</div>
        <div className="lx-row" style={{gap:"10px"}}>
          <LangSwitch />
          <ThemeToggle />
        </div>
      </div>
    </div>
  );
}

function Shell(){
  return (
    <>
      <Topbar />
      <main>
        <ServicesSection />
        <GallerySection />
        <ContactSection />
      </main>
      <Footer />
    </>
  );
}

export default function App(){
  return (
    <LangProvider>
      <Shell />
    </LangProvider>
  );
}
