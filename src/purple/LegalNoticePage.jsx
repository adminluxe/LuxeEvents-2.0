import LegalShell from "./LegalShell.jsx";
import { legalContent } from "./legalContent.js";
import { pageMeta } from "./pageMeta.js";
import { siteConfig } from "./siteConfig.js";
import usePageMeta from "./usePageMeta.js";

export default function LegalNoticePage({ language }) {
  const copy = legalContent[language];
  const page = copy.legal;
  usePageMeta(language === "fr" ? pageMeta.legalFr : pageMeta.legalEn);

  return (
    <LegalShell language={language} alternatePath={language === "fr" ? "/en/legal-notice/" : "/mentions-legales/"}>
      <p className="eyebrow">{page.eyebrow}</p>
      <h1>{page.title}</h1>
      {!siteConfig.isLaunchReady && <p className="legal-alert" data-launch-blocker="legal-identity">{copy.previewBlocker}</p>}

      <section className="legal-section">
        <h2>{page.publisher}</h2>
        <p>{page.brand}</p>
        <dl className="legal-identity">
          <div><dt>{page.labels.publisher}</dt><dd>{siteConfig.legalName}</dd></div>
          <div><dt>{page.labels.form}</dt><dd>{siteConfig.legalForm}</dd></div>
          <div><dt>{page.labels.address}</dt><dd>{siteConfig.legalAddress}</dd></div>
          <div><dt>{page.labels.registration}</dt><dd>{siteConfig.legalRegistration}</dd></div>
          <div><dt>{page.labels.email}</dt><dd>{siteConfig.legalEmail}</dd></div>
          <div><dt>{page.labels.phone}</dt><dd>{siteConfig.legalPhone}</dd></div>
        </dl>
      </section>

      <section className="legal-section"><h2>{page.hosting}</h2><p>{page.hostingText}</p></section>
      <section className="legal-section"><h2>{page.intellectualProperty}</h2><p>{page.intellectualPropertyText}</p></section>
    </LegalShell>
  );
}
