import React from "react";
import {useLang} from "../i18n/LangContext.jsx";
export default function LangSwitch(){
  const {lang, setLang, t} = useLang();
  return (
    <div className="lx-row" role="group" aria-label={t("langLabel")}>
      <span style={{marginRight:".4rem"}}>{t("langLabel")} :</span>
      <button className="lx-btn" style={{borderColor: lang==="fr" ? "#C5A36A" : "#ddd"}} onClick={()=>setLang("fr")}>FR</button>
      <button className="lx-btn" style={{borderColor: lang==="en" ? "#C5A36A" : "#ddd"}} onClick={()=>setLang("en")}>EN</button>
    </div>
  );
}
