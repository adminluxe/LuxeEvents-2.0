import LegalShell from "./LegalShell.jsx";
import { legalContent } from "./legalContent.js";
import { pageMeta } from "./pageMeta.js";
import { siteConfig } from "./siteConfig.js";
import usePageMeta from "./usePageMeta.js";

export default function PrivacyPage({ language }) {
  const copy = legalContent[language];
  const page = copy.privacy;
  usePageMeta(language === "fr" ? pageMeta.privacyFr : pageMeta.privacyEn);

  const retentionText = language === "fr"
    ? `Les demandes effectivement transmises sont conservées pendant ${siteConfig.retentionMonths} mois maximum après le dernier échange, sauf obligation légale ou nécessité liée à la défense de droits.`
    : `Requests that are actually sent are retained for no more than ${siteConfig.retentionMonths} months after the last exchange, unless a legal obligation or the defence of legal rights requires otherwise.`;

  return (
    <LegalShell language={language} alternatePath={language === "fr" ? "/en/privacy/" : "/confidentialite/"}>
      <p className="eyebrow">{page.eyebrow}</p>
      <h1>{page.title}</h1>
      <p className="legal-intro">{page.intro}</p>
      {!siteConfig.isLaunchReady && <p className="legal-alert" data-launch-blocker="privacy-identity">{copy.previewBlocker}</p>}

      <section className="legal-section">
        <h2>{page.sections.controller}</h2>
        <p>{siteConfig.legalName}<br />{siteConfig.legalAddress}<br />{siteConfig.privacyEmail}</p>
      </section>
      <section className="legal-section"><h2>{page.sections.data}</h2><p>{page.dataText}</p></section>
      <section className="legal-section"><h2>{page.sections.legalBasis}</h2><p>{page.legalBasisText}</p></section>
      <section className="legal-section"><h2>{page.sections.recipients}</h2><p>{page.recipientsText}</p></section>
      <section className="legal-section"><h2>{page.sections.retention}</h2><p>{retentionText}</p></section>
      <section className="legal-section"><h2>{page.sections.rights}</h2><p>{page.rightsText} <a href="https://www.autoriteprotectiondonnees.be/" rel="noreferrer">autoriteprotectiondonnees.be</a></p></section>
    </LegalShell>
  );
}
