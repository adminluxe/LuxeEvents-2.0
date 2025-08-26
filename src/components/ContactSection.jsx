import React, {useState} from "react";
import {useLang} from "../i18n/LangContext.jsx";

const BACKEND_FALLBACK = "https://luxeevents-backend-ddcezxmch-adminluxes-projects.vercel.app";

export default function ContactSection(){
  const {t} = useLang();
  const [state, setState] = useState({ name:"", email:"", message:"" });
  const [ok, setOk] = useState(null);

  const submit = async (e)=>{
    e.preventDefault();
    const url = (import.meta.env.VITE_BACKEND_URL || BACKEND_FALLBACK) + "/contact";
    try{
      const r = await fetch(url, {
        method:"POST",
        headers:{ "Content-Type":"application/json" },
        body: JSON.stringify({ ...state })
      });
      setOk(r.ok);
    }catch(_){
      setOk(false);
    }
  };

  return (
    <section className="lx-sec" id="contact">
      <div className="lx-wrap lx-card">
        <div className="lx-pad">
          <h2 className="lx-title">{t("contactTitle")}</h2>
          <p className="lx-muted">{t("contactIntro")}</p>
          <form onSubmit={submit} className="lx-grid" style={{gridTemplateColumns:"1fr", maxWidth:640}}>
            <label><div>{t("name")}</div><input required value={state.name} onChange={e=>setState(s=>({...s, name:e.target.value}))} style={{width:"100%", padding:"10px", border:"1px solid #ddd", borderRadius:8}} /></label>
            <label><div>{t("email")}</div><input type="email" required value={state.email} onChange={e=>setState(s=>({...s, email:e.target.value}))} style={{width:"100%", padding:"10px", border:"1px solid #ddd", borderRadius:8}} /></label>
            <label><div>{t("message")}</div><textarea required rows={5} value={state.message} onChange={e=>setState(s=>({...s, message:e.target.value}))} style={{width:"100%", padding:"10px", border:"1px solid #ddd", borderRadius:8}} /></label>
            <div><button className="lx-btn" type="submit">{t("send")}</button></div>
            {ok === true && <div className="lx-badge" role="status">{t("sentOk")}</div>}
            {ok === false && <div style={{color:"#b00020"}} role="status">{t("sentKo")}</div>}
          </form>
        </div>
      </div>
    </section>
  );
}
