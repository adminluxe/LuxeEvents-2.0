#!/usr/bin/env bash
set -euo pipefail
cd "${1:-.}"

ts="$(date +%Y%m%d-%H%M%S)"
BACKUP="_backup_rewrite_devislanding_${ts}"
mkdir -p "$BACKUP/src/components"

cp -a src/components/DevisLanding.jsx "$BACKUP/src/components/DevisLanding.jsx"
echo "📦 Backup -> $BACKUP/src/components/DevisLanding.jsx"

cat > src/components/DevisLanding.jsx <<'EOF'
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

  const ui = useMemo(() => {
    const field =
      "w-full rounded-2xl bg-black/30 border border-white/10 text-white " +
      "placeholder-white/40 px-4 py-3 outline-none transition " +
      "focus:border-yellow-400/60 focus:ring-2 focus:ring-yellow-400/20";

    const label = "text-sm text-white/75";

    const btnPrimary =
      "inline-flex items-center justify-center gap-2 " +
      "px-6 py-3 rounded-full font-semibold text-black " +
      "bg-gradient-to-r from-yellow-300 via-yellow-400 to-yellow-300 " +
      "shadow-lg shadow-yellow-400/20 transition " +
      "hover:shadow-yellow-400/30 hover:-translate-y-[1px] " +
      "focus:outline-none focus-visible:ring-2 focus-visible:ring-yellow-400/60 " +
      "disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:translate-y-0";

    const btnSecondary =
      "inline-flex items-center justify-center gap-2 " +
      "px-6 py-3 rounded-full font-semibold text-white " +
      "bg-white/10 border border-white/15 transition " +
      "hover:bg-white/15 hover:-translate-y-[1px] " +
      "focus:outline-none focus-visible:ring-2 focus-visible:ring-yellow-400/40 " +
      "disabled:opacity-40 disabled:cursor-not-allowed disabled:hover:translate-y-0";

    const card =
      "w-full max-w-2xl mx-auto " +
      "rounded-3xl border border-white/10 bg-black/30 backdrop-blur-xl " +
      "shadow-2xl shadow-yellow-400/5 " +
      "p-6 sm:p-8";

    return { field, label, btnPrimary, btnSecondary, card };
  }, []);

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
    <section className={ui.card}>
      {/* Si la page /devis a déjà un H1, tu peux supprimer ce H2 */}
      <h2 className="text-2xl sm:text-3xl font-semibold">
        Demande de devis
      </h2>
      <p className="mt-2 text-white/70">
        Réponse rapide. Ambiance premium. Zéro friction.
      </p>

      <form onSubmit={onSubmit} className="mt-6 grid gap-6">
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
          <div className="grid gap-4">
            <label className="grid gap-2">
              <span className={ui.label}>Votre nom *</span>
              <input
                name="name"
                type="text"
                required
                value={form.name}
                onChange={onChange}
                className={ui.field}
                placeholder="Ex: Marie Dupont"
              />
            </label>

            <label className="grid gap-2">
              <span className={ui.label}>Email *</span>
              <input
                name="email"
                type="email"
                required
                value={form.email}
                onChange={onChange}
                className={ui.field}
                placeholder="vous@exemple.com"
              />
            </label>
          </div>
        )}

        {step === 2 && (
          <div className="grid gap-4">
            <label className="grid gap-2">
              <span className={ui.label}>Téléphone</span>
              <input
                name="phone"
                type="tel"
                value={form.phone}
                onChange={onChange}
                className={ui.field}
                placeholder="+32 …"
              />
            </label>

            <label className="grid gap-2">
              <span className={ui.label}>Votre message</span>
              <textarea
                name="message"
                rows={5}
                value={form.message}
                onChange={onChange}
                className={ui.field}
                placeholder="Date, lieu, invités, ambiance, contraintes…"
              />
            </label>
          </div>
        )}

        {step === 3 && (
          <div className="grid gap-3">
            <p className="font-semibold">Récapitulatif</p>
            <ul className="text-sm leading-6 text-white/80">
              <li>
                <span className="text-white/60">Nom:</span>{" "}
                <span className="font-medium">{form.name || "—"}</span>
              </li>
              <li>
                <span className="text-white/60">Email:</span>{" "}
                <span className="font-medium">{form.email || "—"}</span>
              </li>
              <li>
                <span className="text-white/60">Téléphone:</span>{" "}
                <span className="font-medium">{form.phone || "—"}</span>
              </li>
            </ul>
          </div>
        )}

        <div className="actions flex items-center justify-between gap-3 pt-2">
          <button
            type="button"
            onClick={prev}
            disabled={step === 1 || sending}
            className={ui.btnSecondary}
          >
            Précédent
          </button>

          {step < 3 ? (
            <button
              type="button"
              onClick={next}
              disabled={sending}
              className={ui.btnPrimary}
            >
              Suivant
            </button>
          ) : (
            <button type="submit" disabled={sending} className={ui.btnPrimary}>
              {sending ? "Envoi..." : "Envoyer"}
            </button>
          )}
        </div>
      </form>
    </section>
  );
}
EOF

echo "✅ DevisLanding.jsx rewritten (clean layout + luxe UI)."
echo "▶️ Restart dev if needed: pnpm dev"
