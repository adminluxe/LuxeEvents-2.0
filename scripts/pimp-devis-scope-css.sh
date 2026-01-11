#!/usr/bin/env bash
set -euo pipefail
cd "${1:-.}"

ts="$(date +%Y%m%d-%H%M%S)"
BACKUP="_backup_devis_scope_css_${ts}"
mkdir -p "$BACKUP/src/pages" "$BACKUP/src"

for f in src/pages/devis.jsx src/pages/Devis.jsx src/index.css; do
  if [ -f "$f" ]; then
    mkdir -p "$BACKUP/$(dirname "$f")"
    cp -a "$f" "$BACKUP/$f"
  fi
done

echo "📦 Backup -> $BACKUP"

# 1) Force BOTH pages (devis.jsx + Devis.jsx) to same luxe wrapper
mkdir -p src/pages
cat > src/pages/devis.jsx <<'EOF'
import React from "react";
import DevisLanding from "../components/DevisLanding.jsx";

export default function DevisPage() {
  return (
    <main className="devis-scope min-h-screen bg-black text-white">
      <div className="relative">
        <div
          className="absolute inset-0 -z-10 opacity-60"
          style={{
            background:
              "radial-gradient(1200px 600px at 20% 10%, rgba(212,175,55,0.22), transparent 60%), radial-gradient(900px 500px at 80% 20%, rgba(212,175,55,0.12), transparent 55%), radial-gradient(800px 600px at 50% 90%, rgba(255,255,255,0.06), transparent 60%)",
          }}
        />
        <div className="mx-auto w-full max-w-5xl px-4 sm:px-6 lg:px-8 pt-20 sm:pt-24 pb-16">
          <div className="mb-8">
            <p className="text-xs tracking-[0.25em] uppercase text-yellow-300/80">
              LuxeEvents
            </p>
            <h1 className="mt-2 text-3xl sm:text-4xl font-semibold">
              Demande de devis
            </h1>
            <p className="mt-2 text-white/70 max-w-2xl">
              Quelques infos rapides, et on te propose une expérience sur-mesure.
            </p>
          </div>

          <div className="rounded-3xl border border-white/10 bg-black/40 backdrop-blur-xl shadow-2xl shadow-yellow-400/5 p-5 sm:p-7">
            <DevisLanding />
          </div>
        </div>
      </div>
    </main>
  );
}
EOF

cat > src/pages/Devis.jsx <<'EOF'
import React from "react";
import DevisLanding from "../components/DevisLanding.jsx";

export default function DevisPage() {
  return (
    <main className="devis-scope min-h-screen bg-black text-white">
      <div className="relative">
        <div
          className="absolute inset-0 -z-10 opacity-60"
          style={{
            background:
              "radial-gradient(1200px 600px at 20% 10%, rgba(212,175,55,0.22), transparent 60%), radial-gradient(900px 500px at 80% 20%, rgba(212,175,55,0.12), transparent 55%), radial-gradient(800px 600px at 50% 90%, rgba(255,255,255,0.06), transparent 60%)",
          }}
        />
        <div className="mx-auto w-full max-w-5xl px-4 sm:px-6 lg:px-8 pt-20 sm:pt-24 pb-16">
          <div className="mb-8">
            <p className="text-xs tracking-[0.25em] uppercase text-yellow-300/80">
              LuxeEvents
            </p>
            <h1 className="mt-2 text-3xl sm:text-4xl font-semibold">
              Demande de devis
            </h1>
            <p className="mt-2 text-white/70 max-w-2xl">
              Quelques infos rapides, et on te propose une expérience sur-mesure.
            </p>
          </div>

          <div className="rounded-3xl border border-white/10 bg-black/40 backdrop-blur-xl shadow-2xl shadow-yellow-400/5 p-5 sm:p-7">
            <DevisLanding />
          </div>
        </div>
      </div>
    </main>
  );
}
EOF

# 2) Add global scoped styling in src/index.css (Tailwind @apply)
# If already injected, do nothing.
if [ -f src/index.css ]; then
  if ! grep -q "devis-scope" src/index.css; then
    cat >> src/index.css <<'EOF'

/* ────────────────────────────────────────────────────────────────
   LUXEEVENTS — DEVIS SCOPE (force premium UI regardless of markup)
   Applied on pages /devis via .devis-scope wrapper
──────────────────────────────────────────────────────────────── */
@layer components {
  .devis-scope :is(input, select, textarea) {
    @apply w-full rounded-2xl bg-black/30 border border-white/10 text-white
      placeholder-white/40 px-4 py-3 outline-none transition;
    @apply focus:border-yellow-400/50 focus:ring-2 focus:ring-yellow-400/20;
  }

  .devis-scope label {
    @apply text-sm text-white/70;
  }

  .devis-scope :is(button, [role="button"]) {
    @apply inline-flex items-center justify-center gap-2
      px-6 py-3 rounded-full font-semibold text-black
      bg-gradient-to-r from-yellow-300 via-yellow-400 to-yellow-300
      shadow-lg shadow-yellow-400/20 transition;
    @apply hover:shadow-yellow-400/30 hover:-translate-y-[1px];
    @apply focus:outline-none focus-visible:ring-2 focus-visible:ring-yellow-400/60;
  }

  .devis-scope :is(button, [role="button"])[disabled] {
    @apply opacity-50 cursor-not-allowed hover:translate-y-0;
  }

  /* If your form has an action row div, it will look aligned */
  .devis-scope .actions,
  .devis-scope .buttons,
  .devis-scope .cta-row {
    @apply flex flex-wrap gap-3 items-center justify-end;
  }

  /* Make form feel centered even if internal layout is weird */
  .devis-scope form {
    @apply w-full;
  }
}
EOF
  fi
fi

echo "✅ Devis scope applied (pages + CSS)."
echo "➡️ Restart dev to be sure:"
echo "   (stop current dev with Ctrl+C)"
echo "   pnpm dev -- --port 5173"
