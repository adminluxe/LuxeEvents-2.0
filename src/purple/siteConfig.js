const pending = (label) => `À compléter avant publication — ${label}`;

const legalName = String(import.meta.env.VITE_LEGAL_NAME || "").trim();
const legalForm = String(import.meta.env.VITE_LEGAL_FORM || "").trim();
const legalAddress = String(import.meta.env.VITE_LEGAL_ADDRESS || "").trim();
const legalRegistration = String(import.meta.env.VITE_LEGAL_REGISTRATION || "").trim();
const legalEmail = String(import.meta.env.VITE_LEGAL_EMAIL || "").trim();
const legalPhone = String(import.meta.env.VITE_LEGAL_PHONE || "").trim();
const privacyEmail = String(import.meta.env.VITE_PRIVACY_EMAIL || legalEmail).trim();
const retentionMonths = String(import.meta.env.VITE_CONTACT_RETENTION_MONTHS || "").trim();

export const siteConfig = {
  legalName: legalName || pending("identité exacte de l’éditeur"),
  legalForm: legalForm || pending("forme ou statut juridique"),
  legalAddress: legalAddress || pending("adresse de l’éditeur"),
  legalRegistration: legalRegistration || pending("immatriculation ou identification officielle"),
  legalEmail: legalEmail || pending("e-mail public"),
  legalPhone: legalPhone || pending("téléphone public"),
  privacyEmail: privacyEmail || pending("contact vie privée"),
  retentionMonths: retentionMonths || pending("durée de conservation"),
  isLaunchReady: Boolean(
    legalName && legalForm && legalAddress && legalRegistration && legalEmail && legalPhone && privacyEmail && /^\d{1,2}$/.test(retentionMonths),
  ),
};
