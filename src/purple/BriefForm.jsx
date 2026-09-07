import { useMemo, useState } from "react";
import { Link } from "react-router-dom";

const CONTACT_ENDPOINT = String(import.meta.env.VITE_CONTACT_ENDPOINT || "").trim();
const CONTACT_EMAIL = String(import.meta.env.VITE_CONTACT_EMAIL || "").trim();
const EMAIL_PATTERN = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

function buildBrief(form, language) {
  const labels = language === "fr"
    ? ["Type", "Lieu", "Période", "Invités", "Nom", "E-mail", "Intention"]
    : ["Type", "Location", "Timeframe", "Guests", "Name", "Email", "Intent"];
  const values = [form.type, form.location, form.date, form.guests || "—", form.name, form.email, form.message || "—"];
  return labels.map((label, index) => `${label}: ${values[index]}`).join("\n");
}

async function copyText(value) {
  if (navigator.clipboard?.writeText) {
    await navigator.clipboard.writeText(value);
    return;
  }
  const area = document.createElement("textarea");
  area.value = value;
  area.setAttribute("readonly", "");
  area.style.position = "fixed";
  area.style.opacity = "0";
  document.body.appendChild(area);
  area.select();
  document.execCommand("copy");
  area.remove();
}

export default function BriefForm({ copy, language }) {
  const privacyPath = language === "fr" ? "/confidentialite/" : "/en/privacy/";
  const [form, setForm] = useState({
    type: "",
    location: "",
    date: "",
    guests: "",
    name: "",
    email: "",
    message: "",
    consent: false,
    website: "",
  });
  const [status, setStatus] = useState("idle");

  const mode = useMemo(() => {
    if (CONTACT_ENDPOINT) return "endpoint";
    if (CONTACT_EMAIL) return "email";
    return "copy";
  }, []);

  const setField = (event) => {
    const { name, type, value, checked } = event.target;
    setStatus("idle");
    setForm((current) => ({ ...current, [name]: type === "checkbox" ? checked : value }));
  };

  const submit = async (event) => {
    event.preventDefault();
    if (form.website) return;
    if (!form.type || !form.location.trim() || !form.date.trim() || !form.name.trim() || !EMAIL_PATTERN.test(form.email.trim()) || !form.consent) {
      setStatus("required");
      return;
    }

    const brief = buildBrief(form, language);
    setStatus("sending");

    try {
      if (mode === "endpoint") {
        const response = await fetch(CONTACT_ENDPOINT, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ ...form, website: undefined, language, source: "purpleevents.fun" }),
        });
        if (!response.ok) throw new Error(`HTTP ${response.status}`);
        setStatus("success");
        return;
      }

      if (mode === "email") {
        const subject = language === "fr" ? "Brief événement — Purple Events" : "Event brief — Purple Events";
        window.location.assign(`mailto:${CONTACT_EMAIL}?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(brief)}`);
        setStatus("emailReady");
        return;
      }

      await copyText(brief);
      setStatus("copied");
    } catch (error) {
      console.error("Purple Events contact action failed", error);
      setStatus("error");
    }
  };

  const submitLabel = status === "sending"
    ? copy.sending
    : mode === "endpoint"
      ? copy.submitEndpoint
      : mode === "email"
        ? copy.submitEmail
        : copy.submitCopy;

  return (
    <form className="brief-form" onSubmit={submit} noValidate>
      <div className="honeypot" aria-hidden="true">
        <label htmlFor="website">Website</label>
        <input id="website" name="website" value={form.website} onChange={setField} tabIndex="-1" autoComplete="off" />
      </div>

      <label className="field field-wide">
        <span>{copy.type} *</span>
        <select name="type" value={form.type} onChange={setField} required>
          <option value="">{copy.typePlaceholder}</option>
          {copy.typeOptions.map((option) => <option key={option} value={option}>{option}</option>)}
        </select>
      </label>

      <label className="field">
        <span>{copy.location} *</span>
        <input name="location" value={form.location} onChange={setField} placeholder={copy.locationPlaceholder} required />
      </label>

      <label className="field">
        <span>{copy.date} *</span>
        <input name="date" value={form.date} onChange={setField} placeholder={copy.datePlaceholder} required />
      </label>

      <label className="field">
        <span>{copy.guests}</span>
        <input name="guests" inputMode="numeric" value={form.guests} onChange={setField} placeholder={copy.guestsPlaceholder} />
      </label>

      <label className="field">
        <span>{copy.name} *</span>
        <input name="name" autoComplete="name" value={form.name} onChange={setField} placeholder={copy.namePlaceholder} required />
      </label>

      <label className="field field-wide">
        <span>{copy.email} *</span>
        <input name="email" type="email" autoComplete="email" value={form.email} onChange={setField} placeholder={copy.emailPlaceholder} required />
      </label>

      <label className="field field-wide">
        <span>{copy.message}</span>
        <textarea name="message" rows="5" value={form.message} onChange={setField} placeholder={copy.messagePlaceholder} />
      </label>

      <label className="consent field-wide">
        <input name="consent" type="checkbox" checked={form.consent} onChange={setField} />
        <span>{copy.consentBefore}<Link to={privacyPath}>{copy.consentLink}</Link>{copy.consentAfter}</span>
      </label>

      <div className="form-action field-wide">
        <button className="button button-primary" type="submit" disabled={status === "sending"}>
          <span>{submitLabel}</span>
          <span aria-hidden="true">↗</span>
        </button>
        {status !== "idle" && status !== "sending" && (
          <p className={`form-status ${status === "error" || status === "required" ? "is-error" : ""}`} role="status">
            {copy[status]}
          </p>
        )}
      </div>
    </form>
  );
}
