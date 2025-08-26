import React from "react";
import {useLang} from "../i18n/LangContext.jsx";
export default function ServicesSection(){
  const {t, services} = useLang();
  return (
    <section className="lx-sec" id="services">
      <div className="lx-wrap">
        <h2 className="lx-title">{t("servicesTitle")}</h2>
        <ul className="lx-services">
          {services.map((s, i)=>(
            <li key={i}><span className="lx-badge">•</span><div><strong>{s.title}</strong><div className="lx-muted">{s.desc}</div></div></li>
          ))}
        </ul>
        <p><a href="#contact" className="lx-btn">{t("book")}</a></p>
      </div>
    </section>
  );
}
