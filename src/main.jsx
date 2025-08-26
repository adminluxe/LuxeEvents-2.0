import React from "react";
import { createRoot } from "react-dom/client";
import App from "./App.jsx";
import Gallery from './components/Gallery.jsx';
import Footer from './components/Footer.jsx';
import LanguageSwitcher from './components/LanguageSwitcher.jsx';
const el = document.getElementById("root");
createRoot(el).render(<App />);

// extra roots mounting (idempotent)
function mountExtraRoot(id, node){
  const el = document.getElementById(id);
  if(!el) return;
  import('react-dom/client').then(({createRoot})=>{
    const root = createRoot(el);
    root.render(<React.StrictMode>{node}</React.StrictMode>);
  });
}
mountExtraRoot('lang-switcher-root', <LanguageSwitcher />);
mountExtraRoot('gallery-root', <Gallery />);
mountExtraRoot('footer-root', <Footer />);
