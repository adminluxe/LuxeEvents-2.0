import { Navigate, Route, Routes } from "react-router-dom";
import CookieNotice from "./purple/CookieNotice.jsx";
import CookiePolicyPage from "./purple/CookiePolicyPage.jsx";
import LegalNoticePage from "./purple/LegalNoticePage.jsx";
import PurpleLanding from "./purple/PurpleLanding.jsx";
import PrivacyPage from "./purple/PrivacyPage.jsx";

export default function App() {
  return (
    <>
      <Routes>
        <Route path="/" element={<PurpleLanding language="fr" />} />
        <Route path="/en" element={<PurpleLanding language="en" />} />
        <Route path="/confidentialite" element={<PrivacyPage language="fr" />} />
        <Route path="/en/privacy" element={<PrivacyPage language="en" />} />
        <Route path="/cookies" element={<CookiePolicyPage language="fr" />} />
        <Route path="/en/cookies" element={<CookiePolicyPage language="en" />} />
        <Route path="/mentions-legales" element={<LegalNoticePage language="fr" />} />
        <Route path="/en/legal-notice" element={<LegalNoticePage language="en" />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
      <CookieNotice />
    </>
  );
}
