import React, { useState } from "react";

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

  const onChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });
  const next = () => setStep((s) => Math.min(3, s + 1));
  const prev = () => setStep((s) => Math.max(1, s - 1));

  const onSubmit = async (e) => {
    e.preventDefault();
    if (form.hp) return; // bot détecté

    const base = (import.meta.env.VITE_BACKEND_URL || "").replace(/\/$/, "");
    const endpoint = `${base}/api/contact`; // adapte si nécessaire

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
    <section className="w-full max-w-2xl mx-auto p-6">
      <h2 className="text-2xl font-semibold mb-4">Demande de devis</h2>
      <form onSubmit={onSubmit} className="grid gap-6">
        {/* Honeypot anti-bot — toujours présent, invisible */}
        <input
          type="text"
          name="hp"
          value={form.hp}
          onChange={onChange}
          autoComplete="off"
          tabIndex={-1}
          className="hidden absolute opacity-0 pointer-events-none -z-10"
          aria-hidden="true"
        />

        {step === 1 && (
          <div className="grid gap-4">
            <label className="grid gap-1">
              <span className="text-sm">Votre nom *</span>
              <input
                name="name"
                type="text"
                required
                value={form.name}
                onChange={onChange}
                className="w-full rounded-lg border border-neutral-300 bg-white/5 p-3 outline-none focus:ring-2 focus:ring-yellow-400"
                placeholder="Ex: Marie Dupont"
              />
            </label>
            <label className="grid gap-1">
              <span className="text-sm">Email *</span>
              <input
                name="email"
                type="email"
                required
                value={form.email}
                onChange={onChange}
                className="w-full rounded-lg border border-neutral-300 bg-white/5 p-3 outline-none focus:ring-2 focus:ring-yellow-400"
                placeholder="vous@exemple.com"
              />
            </label>
          </div>
        )}

        {step === 2 && (
          <div className="grid gap-4">
            <label className="grid gap-1">
              <span className="text-sm">Téléphone</span>
              <input
                name="phone"
                type="tel"
                value={form.phone}
                onChange={onChange}
                className="w-full rounded-lg border border-neutral-300 bg-white/5 p-3 outline-none focus:ring-2 focus:ring-yellow-400"
                placeholder="+32 …"
              />
            </label>
            <label className="grid gap-1">
              <span className="text-sm">Votre message</span>
              <textarea
                name="message"
                rows={5}
                value={form.message}
                onChange={onChange}
                className="w-full rounded-lg border border-neutral-300 bg-white/5 p-3 outline-none focus:ring-2 focus:ring-yellow-400"
                placeholder="Décrivez votre événement, la date, le lieu, le nombre d'invités, etc."
              />
            </label>
          </div>
        )}

        {step === 3 && (
          <div className="grid gap-2">
            <p className="font-semibold">Récapitulatif</p>
            <ul className="text-sm leading-6">
              <li><strong>Nom:</strong> {form.name || "—"}</li>
              <li><strong>Email:</strong> {form.email || "—"}</li>
              <li><strong>Téléphone:</strong> {form.phone || "—"}</li>
            </ul>
          </div>
        )}

        <div className="flex items-center justify-between gap-3 pt-2">
          <button
            type="button"
            onClick={prev}
            disabled={step === 1 || sending}
            className="rounded-lg border px-4 py-2 disabled:opacity-40"
          >
            Précédent
          </button>

          {step < 3 ? (
            <button
              type="button"
              onClick={next}
              disabled={sending}
              className="rounded-lg bg-yellow-500 text-black px-4 py-2 hover:bg-yellow-400 disabled:opacity-50"
            >
              Suivant
            </button>
          ) : (
            <button
              type="submit"
              disabled={sending}
              className="rounded-lg bg-yellow-500 text-black px-4 py-2 hover:bg-yellow-400 disabled:opacity-50"
            >
              {sending ? "Envoi..." : "Envoyer"}
            </button>
          )}
        </div>
      </form>
    </section>
  );
}
