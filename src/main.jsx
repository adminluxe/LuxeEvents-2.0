import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import "./index.css";
import { HelmetProvider } from "react-helmet-async";
import { BrowserRouter } from "react-router-dom";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <HelmetProvider>
      <BrowserRouter>
        <div style={{ color: "red", background: "white", padding: "20px" }}>
        </div>
        <App />
      </BrowserRouter>
    </HelmetProvider>
  </React.StrictMode>
);
