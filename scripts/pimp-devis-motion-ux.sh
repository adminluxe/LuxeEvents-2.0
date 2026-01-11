#!/usr/bin/env bash
set -euo pipefail
cd "${1:-.}"

ts="$(date +%Y%m%d-%H%M%S)"
BACKUP="_backup_devis_motion_ux_${ts}"
mkdir -p "$BACKUP"

F="src/components/DevisLanding.jsx"
CSS="src/index.css"
PKG="package.json"

[ -f "$F" ] || { echo "❌ Missing $F"; exit 1; }
[ -f "$CSS" ] || { echo "❌ Missing $CSS"; exit 1; }
[ -f "$PKG" ] || { echo "❌ Missing $PKG"; exit 1; }

echo "📦 Backup -> $BACKUP"
cp -a "$F" "$BACKUP/DevisLanding.jsx"
cp -a "$CSS" "$BACKUP/index.css"
cp -a "$PKG" "$BACKUP/package.json"

echo "📦 Ensure framer-motion dependency"
if ! grep -q '"framer-motion"' "$PKG"; then
  echo "➕ Installing framer-motion..."
  pnpm add framer-motion
else
  echo "✅ framer-motion already present"
fi

echo "🎨 Add small luxe UX helpers in index.css (idempotent)"
if ! grep -q "LUXE_DEVIS_MOTION_UX" "$CSS"; then
  cat >> "$CSS" <<'EOF'

/* LUXE_DEVIS_MOTION_UX */
@layer components {
  .luxe-inline-error {
    @apply rounded-2xl border border-red-400/20 bg-red-500/10 text-red-100 px-4 py-3 text-sm;
  }
  .luxe-inline-success {
    @apply rounded-2xl border border-yellow-400/20 bg-yellow-400/10 text-yellow-50 px-4 py-3 text-sm;
  }
  .luxe-hint {
    @apply text-xs text-white/55 italic;
  }
  .luxe-divider {
    @apply h-px w-full bg-gradient-to-r from-transparent via-white/10 to-transparent;
  }
  .luxe-progress {
    @apply h-1.5 rounded-full bg-white/10 overflow-hidden;
  }
  .luxe-progress-bar {
    @apply h-full rounded-full bg-gradient-to-r from-yellow-300 via-yellow-400 to-yellow-300;
  }
  .luxe-cta-row {
    @apply flex flex-col sm:flex-row gap-3 sm:items-center sm:justify-between;
  }
}
EOF
else
  echo "✅ UX helpers already present"
fi

echo "🧠 Rewrite DevisLanding.jsx (motion + inline validation + success state)"
cat > "$F" <<'EOF'
import React, { useMemo, useState } from "react";
import { AnimatePresence, motion } from "framer-motion";
import { Link } from "react-router-dom";

const emailOk = (v) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(String(v || "").trim());

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
  const [error, setError] = useState("");
  const [success, setSuccess] = useState(false);

  const steps = useMemo(
    () => [
      { id: 1, label: "Identité" },
      { id: 2, label: "Détails" },
      { id: 3, label: "Vérif" },
    ],
    []
  );

  const progress = useMemo(() => (step / 3) * 100, [step]);

  const onChange = (e) => {
    setError("");
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const validateStep = (s) => {
    if (s === 1) {
      if (!form.name.trim()) return "Ton nom est requis pour démarrer.";
      if (!emailOk(form.email)) return "Ton email semble incomplet (ex: vous@exemple.com).";
    }
    if (s === 2) {
      // Détails volontairement souples (UX premium = pas bloquant)
      // mais on peut guider : si message vide, pas d'erreur.
    }
    return "";
  };

  const next = () => {
    const msg = validateStep(step);
    if (msg) return setError(msg);
    setStep((s) => Math.min(3, s + 1));
  };

  const prev = () => {
    setError("");
    setStep((s) => Math.max(1, s - 1));
  };

  const resetAll = () => {
    setForm({ name: "", email: "", phone: "", message: "", hp: "" });
    setError("");
    setSuccess(false);
    setStep(1);
  };

  const onSubmit = async (e) => {
    e.preventDefault();
    setError("");
    if (form.hp) return; // bot détecté

    const msg = validateStep(1);
    if (msg) {
      setStep(1);
      return setError(msg);
    }

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

      setSuccess(true);
    } catch (err) {
      console.error(err);
      setError("Envoi impossible pour le moment. Réessaie dans un instant.");
    } finally {
      setSending(false);
    }
  };

  const panelVariants = {
    initial: { opacity: 0, y: 10, filter: "blur(6px)" },
    animate: { opacity: 1, y: 0, filter: "blur(0px)" },
    exit: { opacity: 0, y: -8, filter: "blur(6px)" },
  };

  if (success) {
    return (
      <section className="relative isolate py-14 px-4">
        <div className="mx-auto w-full max-w-3xl luxe-card luxe-card-pad">
          <motion.div
            initial={{ opacity: 0, y: 10, filter: "blur(6px)" }}
            animate={{ opacity: 1, y: 0, filter: "blur(0px)" }}
            transition={{ duration: 0.35, ease: "easeOut" }}
            className="grid gap-6"
          >
            <div>
              <p className="luxe-kicker">Message reçu ✨</p>
              <h1 className="luxe-title mt-2">Demande envoyée</h1>
              <p className="luxe-subtitle">
                Merci. On revient vers toi rapidement avec une proposition claire.
              </p>
            </div>

            <div className="luxe-inline-success">
              Petit tip : si tu ajoutes une date / un lieu / un nombre d’invités, on peut répondre encore plus vite.
            </div>

            <div className="luxe-cta-row">
              <Link
                to="/"
                className="luxe-btn-ghost text-center"
              >
                Retour à l’accueil
              </Link>

              <button
                type="button"
                onClick={resetAll}
                className="luxe-btn"
              >
                Faire une autre demande
              </button>
            </div>
          </motion.div>
        </div>
      </section>
    );
  }

  return (
    <section className="relative isolate py-14 px-4">
      <div className="mx-auto w-full max-w-3xl luxe-card luxe-card-pad">
        <header className="mb-8">
          <p className="luxe-kicker">Réponse rapide. Ambiance premium. Zéro friction.</p>
          <h1 className="luxe-title mt-2">Demande de devis</h1>
          <p className="luxe-subtitle">Quelques infos et on te répond vite avec une proposition claire.</p>

          <div className="mt-6 grid gap-4">
            <div className="luxe-progress" aria-hidden="true">
              <div className="luxe-progress-bar" style={{ width: `${progress}%` }} />
            </div>

            <div className="flex items-center gap-3">
              {steps.map((s) => {
                const active = s.id === step;
                const done = s.id < step;
                return (
                  <div key={s.id} className="flex items-center gap-2">
                    <motion.span
                      className={[
                        "luxe-step-dot",
                        active ? "luxe-step-dot-active" : "",
                      ].join(" ")}
                      animate={{
                        scale: active ? 1.08 : done ? 1.02 : 1,
                        opacity: active ? 1 : done ? 0.9 : 0.55,
                      }}
                      transition={{ duration: 0.25, ease: "easeOut" }}
                      aria-hidden="true"
                    />
                    <span className={active ? "text-white text-sm" : "text-white/50 text-sm"}>
                      {s.label}
                    </span>
                    {s.id !== steps.length && <span className="text-white/20">—</span>}
                  </div>
                );
              })}
            </div>
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

          <AnimatePresence mode="wait">
            {step === 1 && (
              <motion.div
                key="step-1"
                variants={panelVariants}
                initial="initial"
                animate="animate"
                exit="exit"
                transition={{ duration: 0.35, ease: "easeOut" }}
                className="grid gap-5"
              >
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
              </motion.div>
            )}

            {step === 2 && (
              <motion.div
                key="step-2"
                variants={panelVariants}
                initial="initial"
                animate="animate"
                exit="exit"
                transition={{ duration: 0.35, ease: "easeOut" }}
                className="grid gap-5"
              >
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
                  <span className="luxe-hint">Dites-nous l’essentiel pour commencer…</span>
                  <textarea
                    name="message"
                    rows={6}
                    value={form.message}
                    onChange={onChange}
                    className="luxe-textarea"
                    placeholder="Date, lieu, invités, ambiance, prestations souhaitées…"
                  />
                </label>
              </motion.div>
            )}

            {step === 3 && (
              <motion.div
                key="step-3"
                variants={panelVariants}
                initial="initial"
                animate="animate"
                exit="exit"
                transition={{ duration: 0.35, ease: "easeOut" }}
                className="grid gap-5"
              >
                <div className="grid gap-3">
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
                      <li className="mt-2">
                        <span className="text-white/60">Message :</span>{" "}
                        <span className="text-white">{form.message?.trim() ? "✅" : "—"}</span>
                      </li>
                    </ul>
                  </div>

                  <div className="luxe-divider" />

                  <p className="text-white/60 text-sm">
                    En cliquant sur <span className="text-white">Envoyer</span>, ta demande part directement à l’équipe.
                  </p>
                </div>
              </motion.div>
            )}
          </AnimatePresence>

          {error && (
            <motion.div
              role="alert"
              className="luxe-inline-error"
              initial={{ opacity: 0, y: 6 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.22, ease: "easeOut" }}
            >
              {error}
            </motion.div>
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
EOF

echo "✅ Motion + UX premium applied."
echo "▶️ Restart dev: Ctrl+C then pnpm dev -- --port 5173 --strictPort"
