import React, { useState } from "react";
import { sendContact } from "../lib/contact.js";

export default function ContactForm(){
  const [loading, setLoading] = useState(false);

  async function onSubmit(e){
    e.preventDefault();
    const fd = new FormData(e.currentTarget);

    // Honeypot
    if ((fd.get("website") || "").toString().trim()) {
      e.currentTarget.reset();
      return;
    }

    const payload = {
      name:   (fd.get("name")   || "").toString().trim(),
      email:  (fd.get("email")  || "").toString().trim(),
      phone:  (fd.get("phone")  || "").toString().trim(),
      date:   (fd.get("date")   || "").toString().trim(),
      budget: (fd.get("budget") || "").toString().trim(),
      topic:  (fd.get("topic")  || "").toString().trim(),
      message:(fd.get("message")|| "").toString().trim(),
      website:(fd.get("website")|| "").toString(), // honeypot
      turnstileToken: (fd.get("cf-turnstile-response") || "").toString(),
      page: (typeof window!=="undefined"?window.location.pathname:""),
      source: (typeof document!=="undefined"?document.referrer:"")
    };

    if (!payload.name)  return alert("Nom requis");
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(payload.email)) return alert("Email valide requis");

    try{
      setLoading(true);
      await sendContact(payload);
      const lang = (document.documentElement.lang||"fr").slice(0,2);
      window.location.assign(lang==="fr"?"/merci?ok=1":"/thanks?ok=1");
    } catch(err){
      console.error(err);
      alert("Oups, envoi impossible : " + (err?.message || "Erreur réseau"));
    } finally{
      setLoading(false);
    }
  }

  return (
    <form onSubmit={onSubmit} style={{display:"grid",gap:".8rem",maxWidth:720}}>
      <label>Nom<input className="input" name="name" placeholder="Ex. Marie Dupont" required /></label>
      <label>Email<input className="input" type="email" name="email" placeholder="you@domain.tld" required /></label>

      <div style={{display:"grid",gap:".8rem",gridTemplateColumns:"1fr 1fr"}}>
        <label>Téléphone<input className="input" name="phone" placeholder="+33 ..." /></label>
        <label>Date<input className="input" name="date" type="date" /></label>
      </div>

      <div style={{display:"grid",gap:".8rem",gridTemplateColumns:"1fr 1fr"}}>
        <label>Budget<input className="input" name="budget" placeholder="€" /></label>
        <label>Sujet<input className="input" name="topic" placeholder="Type d’événement" /></label>
      </div>

      <label>Message<textarea className="textarea" name="message" placeholder="Dites-nous l’essentiel pour commencer…"/></label>

      {/* Honeypot + Turnstile placeholder */}
      <input type="text" name="website" tabIndex="-1" autoComplete="off" style={{position:"absolute",left:"-9999px"}} aria-hidden="true"/>
      <input type="hidden" name="cf-turnstile-response"/>

      <button className="btn primary" type="submit" disabled={loading} data-variant="primary">
        {loading ? "Envoi…" : "Envoyer la demande"}
      </button>
    </form>
  );
}
