document.documentElement.classList.add("js");
import React from "react";
document.documentElement.classList.add("js");
import { createRoot } from "react-dom/client";
document.documentElement.classList.add("js");
import safeRegisterSW from "./pwa-register.js";
document.documentElement.classList.add("js");

const ensureRoot = () => {
  let el = document.getElementById("root");
  if (!el) { el = document.createElement("div"); el.id = "root"; document.body.appendChild(el); }
  return el;
};

const root = createRoot(ensureRoot());

function Fallback() {
  return (
    <div style={{position:"relative", zIndex: 2}}>
      <header style={{padding:"16px 24px", display:"flex", gap:16, alignItems:"center"}}>
        <strong style={{fontFamily:"Playfair Display, serif", fontSize:22}}>LuxeEvents</strong>
        <nav style={{display:"flex", gap:16}}>
          <a href="#accueil">Accueil</a>
          <a href="#services">Services</a>
          <a href="#devis">Devis</a>
        </nav>
      </header>
      <main style={{padding:"24px"}}>
        <h1 style={{margin:"24px 0 12px"}}>Chargement…</h1>
        <p>Une petite subtilité technique, la page se remet en place.</p>
        <p><a href="/devis">Aller au formulaire de devis</a></p>
      </main>
      <footer style={{padding:"24px"}}>© LuxeEvents</footer>
    </div>
  );
}

async function boot() {
  try {
    const mod = await import("./AppShell.jsx");
    const AppShell = mod.default || mod.AppShell || (() => null);
    root.render(
      <React.StrictMode>
        <AppShell />
      </React.StrictMode>
    );
  } catch (err) {
    console.error("[LuxeEvents] Boot error → fallback:", err);
    root.render(<Fallback />);
  }
}

// Safety nets
window.addEventListener("error", (e) => console.error("[LuxeEvents] window.error:", e.error || e.message));
window.addEventListener("unhandledrejection", (e) => console.error("[LuxeEvents] unhandledrejection:", e.reason));
boot();
