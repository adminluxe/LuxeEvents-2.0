import React, { useMemo, useState } from "react";

export default function DevisLanding() {
  const [step, setStep] = useState(1);
  const [form, setForm] = useState({
    name: "",
    email: "",
    phone: "",
    message: "",
    hp: "", // honeypot
  });
  const [sending, setSending] = useState(false);

  const steps = useMemo(
    () => [
      { id: 1, label: "Identité" },
      { id: 2, label: "Détails" },
      { id: 3, label: "Vérif" },
    ],
    []
  );

  const onChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });
  const next = () => setStep((s) => Math.min(3, s + 1));
  const prev = () => setStep((s) => Math.max(1, s - 1));

  const onSubmit = async (e) => {
    e.preventDefault();
    if (form.hp) return; // bot détecté

    const base = (import.meta.env.VITE_BACKEND_URL || "").replace(/\/$/, "");
    const endpoint = `${base}/api/contact`;

    try {
      setSending(true);
      const res = await fetch(endpoint, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: form.name,
          email: form.email,
          phone: form.phone,
          message: form.message,
          source: "devis-landing",
        }),
      });

      if (!res.ok) {
        const txt = await res.text().catch(() => "");
        throw new Error(`HTTP ${res.status} – ${txt}`);
      }

      alert("Votre demande de devis a été envoyée. Merci !");
      setForm({ name: "", email: "", phone: "", message: "", hp: "" });
      setStep(1);
    } catch (err) {
      console.error(err);
      alert("Envoi impossible pour le moment. Réessayez plus tard.");
    } finally {
      setSending(false);
    }
  };

  return (
    <section className="relative isolate py-14 px-4">
      <div className="mx-auto w-full max-w-3xl luxe-card luxe-card-pad">
        <header className="mb-8">
          <p className="luxe-kicker">Réponse rapide. Ambiance premium. Zéro friction.</p>
          <h1 className="luxe-title mt-2">Demande de devis</h1>
          <p className="luxe-subtitle">
            Quelques infos et on te répond vite avec une proposition claire.
          </p>

          <div className="mt-6 flex items-center gap-3">
            {steps.map((s) => (
              <div key={s.id} className="flex items-center gap-2">
                <span
                  className={[
                    "luxe-step-dot",
                    s.id === step ? "luxe-step-dot-active" : "",
                  ].join(" ")}
                  aria-hidden="true"
                />
                <span className={s.id === step ? "text-white text-sm" : "text-white/50 text-sm"}>
                  {s.label}
                </span>
                {s.id !== steps.length && <span className="text-white/20">—</span>}
              </div>
            ))}
          </div>
        </header>

        <form onSubmit={onSubmit} className="grid gap-6">
          {/* Honeypot anti-bot — toujours présent, invisible */}
          <input
            type="text"
            name="hp"
            value={form.hp}
            onChange={onChange}
            autoComplete="off"
            tabIndex={-1}
            className="hidden"
            aria-hidden="true"
          />

          {step === 1 && (
            <div className="grid gap-5">
              <label className="grid gap-2">
                <span className="luxe-label">Votre nom *</span>
                <input
                  name="name"
                  type="text"
                  required
                  value={form.name}
                  onChange={onChange}
                  className="luxe-input"
                  placeholder="Ex: Marie Dupont"
                />
              </label>

              <label className="grid gap-2">
                <span className="luxe-label">Email *</span>
                <input
                  name="email"
                  type="email"
                  required
                  value={form.email}
                  onChange={onChange}
                  className="luxe-input"
                  placeholder="vous@exemple.com"
                />
              </label>
            </div>
          )}

          {step === 2 && (
            <div className="grid gap-5">
              <label className="grid gap-2">
                <span className="luxe-label">Téléphone</span>
                <input
                  name="phone"
                  type="tel"
                  value={form.phone}
                  onChange={onChange}
                  className="luxe-input"
                  placeholder="+32 …"
                />
              </label>

              <label className="grid gap-2">
                <span className="luxe-label">Votre message</span>
                <textarea
                  name="message"
                  rows={6}
                  value={form.message}
                  onChange={onChange}
                  className="luxe-textarea"
                  placeholder="Décrivez votre événement : date, lieu, invités, ambiance, prestations…"
                />
              </label>
            </div>
          )}

          {step === 3 && (
            <div className="grid gap-4">
              <p className="text-white font-semibold">Récapitulatif</p>
              <div className="rounded-2xl border border-white/10 bg-black/25 p-4 text-white/80">
                <ul className="text-sm leading-7">
                  <li>
                    <span className="text-white/60">Nom :</span>{" "}
                    <span className="text-white">{form.name || "—"}</span>
                  </li>
                  <li>
                    <span className="text-white/60">Email :</span>{" "}
                    <span className="text-white">{form.email || "—"}</span>
                  </li>
                  <li>
                    <span className="text-white/60">Téléphone :</span>{" "}
                    <span className="text-white">{form.phone || "—"}</span>
                  </li>
                </ul>
              </div>
              <p className="text-white/60 text-sm">
                En cliquant sur <span className="text-white">Envoyer</span>, ta demande part directement à l’équipe.
              </p>
            </div>
          )}

          <div className="flex items-center justify-between gap-3 pt-2">
            <button
              type="button"
              onClick={prev}
              disabled={step === 1 || sending}
              className="luxe-btn-ghost"
            >
              Précédent
            </button>

            {step < 3 ? (
              <button type="button" onClick={next} disabled={sending} className="luxe-btn">
                Suivant
              </button>
            ) : (
              <button type="submit" disabled={sending} className="luxe-btn">
                {sending ? "Envoi..." : "Envoyer"}
              </button>
            )}
          </div>
        </form>
      </div>
    </section>
  );
}
