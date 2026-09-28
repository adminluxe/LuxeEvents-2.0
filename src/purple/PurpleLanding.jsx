import { useState } from "react";
import { Link } from "react-router-dom";
import BrandMark from "./BrandMark.jsx";
import BriefForm from "./BriefForm.jsx";
import { content } from "./content.js";
import { legalContent } from "./legalContent.js";
import { pageMeta } from "./pageMeta.js";
import usePageMeta from "./usePageMeta.js";

function SectionHeading({ eyebrow, title, text }) {
  return (
    <header className="section-heading">
      <p className="eyebrow">{eyebrow}</p>
      <h2>{title}</h2>
      {text && <p className="section-intro">{text}</p>}
    </header>
  );
}

export default function PurpleLanding({ language }) {
  const [menuOpen, setMenuOpen] = useState(false);
  const copy = content[language];
  const legalCopy = legalContent[language];
  const homePath = language === "fr" ? "/" : "/en/";
  const languagePath = language === "fr" ? "/en/" : "/";
  const privacyPath = language === "fr" ? "/confidentialite/" : "/en/privacy/";
  const cookiesPath = language === "fr" ? "/cookies/" : "/en/cookies/";
  const legalPath = language === "fr" ? "/mentions-legales/" : "/en/legal-notice/";
  usePageMeta(language === "fr" ? pageMeta.homeFr : pageMeta.homeEn);
  const closeMenu = () => setMenuOpen(false);

  return (
    <div className="site-shell">
      <a className="skip-link" href="#main">{copy.skip}</a>

      <header className="site-header">
        <Link to={`${homePath}#top`} className="brand-link" onClick={closeMenu}><BrandMark /></Link>
        <button
          className="menu-button"
          type="button"
          aria-expanded={menuOpen}
          aria-controls="site-navigation"
          aria-label={menuOpen ? copy.closeMenu : copy.menu}
          onClick={() => setMenuOpen((open) => !open)}
        >
          <span /><span />
        </button>
        <nav id="site-navigation" className={menuOpen ? "site-nav is-open" : "site-nav"} aria-label={copy.navLabel}>
          <a href="#approche" onClick={closeMenu}>{copy.nav.approach}</a>
          <a href="#expertises" onClick={closeMenu}>{copy.nav.expertise}</a>
          <a href="#methode" onClick={closeMenu}>{copy.nav.method}</a>
          <a href="#brief" className="nav-cta" onClick={closeMenu}>{copy.nav.brief}</a>
          <Link className="language-button" to={languagePath} aria-label={copy.language} onClick={closeMenu}>
            {copy.languageCode}
          </Link>
        </nav>
      </header>

      <main id="main">
        <section className="hero" id="top">
          <img className="hero-image" src="/images/purple-events-hero-v1.webp" alt="" fetchPriority="high" />
          <div className="hero-veil" aria-hidden="true" />
          <div className="hero-grain" aria-hidden="true" />
          <div className="hero-content">
            <p className="eyebrow hero-eyebrow"><span />{copy.eyebrow}</p>
            <h1>{copy.title}</h1>
            <p className="hero-lead">{copy.lead}</p>
            <div className="hero-actions">
              <a className="button button-primary" href="#brief"><span>{copy.primaryCta}</span><span aria-hidden="true">↗</span></a>
              <a className="button button-ghost" href="#approche"><span>{copy.secondaryCta}</span><span aria-hidden="true">↓</span></a>
            </div>
            <ul className="hero-highlights" aria-label="">
              {copy.highlights.map((item) => <li key={item}>{item}</li>)}
            </ul>
          </div>
          <div className="hero-index" aria-hidden="true">PE / 01</div>
        </section>

        <section className="section approach" id="approche">
          <SectionHeading eyebrow={copy.approachEyebrow} title={copy.approachTitle} text={copy.approachText} />
          <div className="principles">
            {copy.principles.map((principle) => (
              <article className="principle" key={principle.number}>
                <span>{principle.number}</span><h3>{principle.title}</h3><p>{principle.text}</p>
              </article>
            ))}
          </div>
        </section>

        <section className="section expertise" id="expertises">
          <SectionHeading eyebrow={copy.expertiseEyebrow} title={copy.expertiseTitle} text={copy.expertiseText} />
          <div className="services-list">
            {copy.services.map((service) => (
              <article className="service" key={service.index}>
                <span className="service-index">{service.index}</span><h3>{service.title}</h3><p>{service.text}</p><span className="service-mark" aria-hidden="true">✦</span>
              </article>
            ))}
          </div>
        </section>

        <section className="section method" id="methode">
          <SectionHeading eyebrow={copy.methodEyebrow} title={copy.methodTitle} />
          <ol className="method-steps">
            {copy.steps.map((item, index) => (
              <li key={item.step}><span>{String(index + 1).padStart(2, "0")}</span><div><h3>{item.step}</h3><p>{item.text}</p></div></li>
            ))}
          </ol>
        </section>

        <section className="section brief-section" id="brief">
          <div className="brief-copy">
            <SectionHeading eyebrow={copy.briefEyebrow} title={copy.briefTitle} text={copy.briefText} />
            <div className="brief-orbit" aria-hidden="true"><span>PE</span></div>
          </div>
          <BriefForm copy={copy.form} language={language} />
        </section>
      </main>

      <footer className="site-footer">
        <BrandMark />
        <p>{copy.footerLine}</p>
        <div className="footer-meta">
          <Link to={privacyPath}>{legalCopy.footer.privacy}</Link>
          <Link to={cookiesPath}>{legalCopy.footer.cookies}</Link>
          <Link to={legalPath}>{legalCopy.footer.legal}</Link>
          <span>© {new Date().getFullYear()} Purple Events</span>
          <span className="footer-separator" aria-hidden="true">·</span>
          <span>{copy.groupInitiative}</span>
        </div>
      </footer>
    </div>
  );
}
