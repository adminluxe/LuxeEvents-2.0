import { useEffect, useState } from "react";
import { Link, useLocation } from "react-router-dom";
import { legalContent } from "./legalContent.js";

const STORAGE_KEY = "purple-events-cookie-notice";
const STORAGE_VERSION = 1;
const MAX_AGE_MS = 180 * 24 * 60 * 60 * 1000;

function isAcknowledged() {
  try {
    const stored = JSON.parse(window.localStorage.getItem(STORAGE_KEY) || "null");
    return stored?.version === STORAGE_VERSION && Number(stored.expiresAt) > Date.now();
  } catch {
    return false;
  }
}

export default function CookieNotice() {
  const location = useLocation();
  const language = location.pathname.startsWith("/en") ? "en" : "fr";
  const copy = legalContent[language].notice;
  const detailsPath = language === "fr" ? "/cookies/" : "/en/cookies/";
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    setVisible(!isAcknowledged());
  }, []);

  const acknowledge = () => {
    try {
      window.localStorage.setItem(STORAGE_KEY, JSON.stringify({
        version: STORAGE_VERSION,
        expiresAt: Date.now() + MAX_AGE_MS,
      }));
    } catch {
      // The notice can still be dismissed for the current page view.
    }
    setVisible(false);
  };

  if (!visible) return null;

  return (
    <aside className="cookie-notice" aria-label={copy.label}>
      <div>
        <p className="cookie-kicker">{copy.label}</p>
        <p>{copy.text}</p>
      </div>
      <div className="cookie-actions">
        <Link to={detailsPath}>{copy.details}</Link>
        <button type="button" onClick={acknowledge}>{copy.accept}</button>
      </div>
    </aside>
  );
}
