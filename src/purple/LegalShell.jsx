import { Link } from "react-router-dom";
import BrandMark from "./BrandMark.jsx";
import { legalContent } from "./legalContent.js";

export default function LegalShell({ language, alternatePath, children }) {
  const copy = legalContent[language];
  const home = language === "fr" ? "/" : "/en/";

  return (
    <main className="legal-page">
      <div className="legal-topline">
        <Link to={home} className="brand-link"><BrandMark /></Link>
        <Link className="language-button" to={alternatePath} aria-label={copy.language}>{copy.languageCode}</Link>
      </div>
      <article>
        {children}
        <Link className="button button-ghost legal-back" to={home}>← {copy.back}</Link>
      </article>
    </main>
  );
}
