import React from "react";
import { useTranslation } from "react-i18next";

export default function Footer() {
  const { t } = useTranslation();
  return (
    <footer className="bg-gray-900 text-white text-center py-6">
      <p>{t("footer.copy")}</p>
      <p>{t("footer.contact")}: <a href="mailto:info@luxeevents.me" className="underline">info@luxeevents.me</a></p>
    </footer>
  );
}
