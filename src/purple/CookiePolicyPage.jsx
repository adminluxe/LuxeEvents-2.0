import LegalShell from "./LegalShell.jsx";
import { legalContent } from "./legalContent.js";
import { pageMeta } from "./pageMeta.js";
import usePageMeta from "./usePageMeta.js";

export default function CookiePolicyPage({ language }) {
  const copy = legalContent[language];
  const page = copy.cookies;
  usePageMeta(language === "fr" ? pageMeta.cookiesFr : pageMeta.cookiesEn);

  return (
    <LegalShell language={language} alternatePath={language === "fr" ? "/en/cookies/" : "/cookies/"}>
      <p className="eyebrow">{page.eyebrow}</p>
      <h1>{page.title}</h1>
      <p className="legal-intro">{page.intro}</p>

      <section className="legal-section">
        <h2>{page.tableTitle}</h2>
        <div className="legal-table-wrap">
          <table className="legal-table">
            <thead><tr>{page.tableHeaders.map((header) => <th key={header}>{header}</th>)}</tr></thead>
            <tbody>{page.rows.map((row) => <tr key={row.name}><td><code>{row.name}</code></td><td>{row.purpose}</td><td>{row.duration}</td><td>{row.type}</td></tr>)}</tbody>
          </table>
        </div>
      </section>

      <section className="legal-section"><h2>{page.infrastructureTitle}</h2><p>{page.infrastructureText}</p></section>
      <section className="legal-section"><h2>{page.consentTitle}</h2><p>{page.consentText}</p></section>
      <section className="legal-section"><h2>{page.controlTitle}</h2><p>{page.controlText}</p></section>
    </LegalShell>
  );
}
