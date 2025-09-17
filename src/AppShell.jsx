import React, { useEffect, useState } from "react";
import "./boot/stars.js";
import ContactForm from "./components/ContactForm.jsx";

export default function AppShell(){
  const [theme,setTheme] = useState("dark");
  const [lang,setLang] = useState("fr");

  useEffect(()=>{
    const d = document.documentElement;
    const t = localStorage.getItem("theme") || "dark";
    const l = localStorage.getItem("lang") || "fr";
    setTheme(t); setLang(l);
    d.classList.toggle("dark", t==="dark");
    d.lang = l;
  },[]);

  const toggleTheme = ()=>{
    const d = document.documentElement;
    const t = (theme==="dark" ? "light" : "dark");
    setTheme(t); localStorage.setItem("theme", t);
    d.classList.toggle("dark", t==="dark");
  };
  const toggleLang = ()=>{
    const l = (lang==="fr" ? "en" : "fr");
    setLang(l); localStorage.setItem("lang", l);
    document.documentElement.lang = l;
  };

  return (
    <>
      <header role="banner" className="site-header">
        <div className="container nav">
          <strong style={{fontFamily:"Playfair Display, serif", fontSize:20}}>LuxeEvents</strong>
          <nav aria-label="Sections">
            <a href="#accueil">{lang==="fr" ? "Accueil" : "Home"}</a>
            <a href="#services">{lang==="fr" ? "Services" : "Services"}</a>
            <a href="#devis">{lang==="fr" ? "Devis" : "Quote"}</a>
          </nav>
          <div className="toggles" style={{marginLeft:"auto"}}>
            <button className="btn btn-ghost" onClick={toggleLang} aria-label="Lang">FR/EN</button>
            <button className="btn btn-ghost" onClick={toggleTheme} aria-label="Theme">{theme==="dark" ? "☾" : "☀︎"}</button>
          </div>
        </div>
      </header>

      <main id="accueil">
        <section className="section hero">
          <div className="container">
            <h1>{lang==="fr"
              ? "L’art de l’événement, l’excellence à la portée de tous."
              : "The art of events, excellence within reach."}</h1>
            <p>{lang==="fr"
              ? "Nous concevons des expériences sur-mesure, impeccables, avec une touche d’audace."
              : "We craft tailor-made experiences with flawless execution and a dash of boldness."}
            </p>
            <div style={{display:"flex",gap:12,justifyContent:"center",marginTop:12}}>
              <a className="btn btn-primary" href="#devis">{lang==="fr" ? "Obtenir un devis" : "Get a quote"}</a>
              <a className="btn btn-ghost" href="#services">{lang==="fr" ? "Découvrir nos services" : "Explore services"}</a>
            </div>
          </div>
        </section>

        <section id="services" className="section">
          <div className="container">
            <h2 style={{margin:"0 0 16px"}}>{lang==="fr" ? "Nos Services" : "Our Services"}</h2>
            <div className="cards">
              <article className="card">
                <h3>{lang==="fr" ? "Événements Corporate" : "Corporate Events"}</h3>
                <p>{lang==="fr"
                  ? "Conventions, lancements, séminaires et soirées de direction. Coordination millimétrée, showcalling, équipes hôtesses et reporting post-event."
                  : "Conferences, launches and leadership evenings. Minute-perfect coordination, showcalling, premium staffing and post-event reporting."}
                </p>
              </article>
              <article className="card">
                <h3>{lang==="fr" ? "Expériences de Marque" : "Brand Experiences"}</h3>
                <p>{lang==="fr"
                  ? "Pop-ups immersifs, roadshows et activations retail. Concepts clés en main, création de contenus, UGC & influence, mesure d’impact."
                  : "Immersive pop-ups, roadshows and retail activations. Turn-key concepts, content creation, UGC & influencer ops, impact tracking."}
                </p>
              </article>
              <article className="card">
                <h3>{lang==="fr" ? "Scénographie & Technique" : "Scenography & Tech"}</h3>
                <p>{lang==="fr"
                  ? "Direction artistique, plans et moodboards. Son, lumière, vidéo, LED, mapping, livestream multicam — équipes certifiées & conformité sécurité."
                  : "Art direction, drawings & moodboards. Audio, lighting, video, LED, projection mapping, multicam livestream — certified crews & compliance."}
                </p>
              </article>
              <article className="card">
                <h3>{lang==="fr" ? "Conciergerie & Logistique" : "Concierge & Logistics"}</h3>
                <p>{lang==="fr"
                  ? "Invitations & RSVP, flotte premium, sécurité, hébergements, chefs privés & mixologie, micro-logistique de dernière minute."
                  : "Invites & RSVP, premium fleet, security, accommodation, private chefs & mixology, last-mile logistics."}
                </p>
              </article>
            </div>
          </div>
        </section>

        <section id="devis" className="section">
          <div className="container">
            <h2 style={{margin:"0 0 16px"}}>{lang==="fr" ? "Parlez-nous de votre projet" : "Tell us about your project"}</h2>
            <p style={{margin:"0 0 16px"}}>{lang==="fr" ? "Dites-nous l’essentiel : réponse sous 24h." : "Share the essentials—reply within 24h."}</p>
            {/* ContactForm (déjà présent dans le projet) */}
            <ContactForm />
          </div>
        </section>
      </main>

      <footer className="section" style={{paddingTop:24}}>
        <div className="container" style={{display:"flex",gap:16,flexWrap:"wrap",justifyContent:"space-between"}}>
          <small>© {new Date().getFullYear()} LuxeEvents — Tous droits réservés.</small>
          <nav>
            <a href="/mentions-legales.html" style={{marginRight:12}}>Mentions légales</a>
            <a href="/confidentialite.html" style={{marginRight:12}}>Confidentialité</a>
            <a href="/sitemap.xml">Sitemap</a>
          </nav>
        </div>
      </footer>
    </>
  );
}
