import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import "./styles/luxe.css";
import { LangProvider } from "./i18n/LangContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <LangProvider>
      <App />
    </LangProvider>
  </React.StrictMode>
);

// SW registration guard (no more .register.serviceWorker nonsense)
if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker.register("/sw.js").catch(() => {});
  });
}
