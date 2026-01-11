import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter } from "react-router-dom";

import App from "./App.jsx";
import "./index.css";

import NavBarLuxe from "./components/NavBarLuxe.jsx";
import HashScroller from "./components/HashScroller.jsx";
import { registerSW } from "./registerSW.js";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <BrowserRouter>
      {/* Ancres (#services, #faq, etc.) + offset navbar */}
      <HashScroller />
      {/* Navbar globale (1 seule fois, ici) */}
      <NavBarLuxe />
      {/* App / Routes */}
      <App />
    </BrowserRouter>
  </React.StrictMode>
);

// SW uniquement en prod (guard dans registerSW)
registerSW();
