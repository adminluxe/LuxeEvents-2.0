const pending = (label) => `À compléter avant publication — ${label}`;

const legalName = String(import.meta.env.VITE_LEGAL_NAME || "").trim();
const legalAddress = String(import.meta.env.VITE_LEGAL_ADDRESS || "").trim();
const enterpriseNumber = String(import.meta.env.VITE_LEGAL_ENTERPRISE_NUMBER || "").trim();
const legalEmail = String(import.meta.env.VITE_LEGAL_EMAIL || "").trim();
const legalPhone = String(import.meta.env.VITE_LEGAL_PHONE || "").trim();
const privacyEmail = String(import.meta.env.VITE_PRIVACY_EMAIL || legalEmail).trim();
const retentionMonths = String(import.meta.env.VITE_CONTACT_RETENTION_MONTHS || "").trim();

export const siteConfig = {
  legalName: legalName || pending("dénomination légale"),
  legalAddress: legalAddress || pending("adresse d’établissement"),
  enterpriseNumber: enterpriseNumber || pending("numéro d’entreprise / TVA"),
  legalEmail: legalEmail || pending("e-mail public"),
  legalPhone: legalPhone || pending("téléphone public"),
  privacyEmail: privacyEmail || pending("contact vie privée"),
  retentionMonths: retentionMonths || pending("durée de conservation"),
  isLaunchReady: Boolean(
    legalName && legalAddress && enterpriseNumber && legalEmail && legalPhone && privacyEmail && /^\d{1,2}$/.test(retentionMonths),
  ),
};
