#!/usr/bin/env bash
set -euo pipefail
cd "${1:-.}"

latest_backup="$(ls -1d _backup_devis_scope_css_* 2>/dev/null | sort | tail -n 1 || true)"
if [ -z "${latest_backup}" ]; then
  echo "❌ Aucun backup _backup_devis_scope_css_* trouvé. Stop."
  exit 1
fi

ts="$(date +%Y%m%d-%H%M%S)"
BACKUP="_backup_fix_devis_scope_tailwind4_${ts}"
mkdir -p "$BACKUP/src"

# backup current
if [ -f src/index.css ]; then
  cp -a src/index.css "$BACKUP/src/index.css"
fi

echo "🧯 Restore src/index.css depuis: ${latest_backup}/src/index.css"
cp -a "${latest_backup}/src/index.css" src/index.css

# remove any previous injected "DEVIS SCOPE" block if it exists in restored file (safety)
tmp="$(mktemp)"
awk '
  BEGIN{skip=0}
  /LUXEEVENTS — DEVIS SCOPE/ {skip=1}
  skip==0 {print}
  /END DEVIS SCOPE/ {skip=0; next}
' src/index.css > "$tmp" && mv "$tmp" src/index.css

echo "✍️ Inject CSS scope (no @apply, Tailwind-proof)"
cat >> src/index.css <<'EOF'

/* ────────────────────────────────────────────────────────────────
   LUXEEVENTS — DEVIS SCOPE (NO @APPLY, Tailwind v4 safe)
   Applied on pages /devis via .devis-scope wrapper
   END DEVIS SCOPE
──────────────────────────────────────────────────────────────── */

.devis-scope :is(input, select, textarea) {
  width: 100%;
  border-radius: 16px;
  background: rgba(0,0,0,0.30);
  border: 1px solid rgba(255,255,255,0.12);
  color: #fff;
  padding: 0.75rem 1rem;
  outline: none;
  transition: border-color 180ms ease, box-shadow 180ms ease, transform 180ms ease;
}

.devis-scope :is(input, select, textarea)::placeholder {
  color: rgba(255,255,255,0.45);
}

.devis-scope :is(input, select, textarea):focus {
  border-color: rgba(212,175,55,0.65);
  box-shadow: 0 0 0 2px rgba(212,175,55,0.18);
}

.devis-scope label {
  display: inline-block;
  margin-bottom: 0.35rem;
  font-size: 0.9rem;
  color: rgba(255,255,255,0.75);
}

.devis-scope :is(button, [role="button"], input[type="submit"]) {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  border-radius: 9999px;
  font-weight: 700;
  color: #111;
  background: linear-gradient(90deg, #f6d365, #fda085, #f6d365);
  border: none;
  box-shadow: 0 10px 24px rgba(212,175,55,0.18);
  cursor: pointer;
  transition: transform 180ms ease, box-shadow 180ms ease, filter 180ms ease, opacity 180ms ease;
}

.devis-scope :is(button, [role="button"], input[type="submit"]):hover {
  transform: translateY(-1px);
  box-shadow: 0 14px 30px rgba(212,175,55,0.25);
  filter: saturate(1.05);
}

.devis-scope :is(button, [role="button"], input[type="submit"]):focus {
  outline: none;
  box-shadow: 0 0 0 2px rgba(212,175,55,0.22), 0 14px 30px rgba(212,175,55,0.25);
}

.devis-scope :is(button, [role="button"], input[type="submit"])[disabled],
.devis-scope :is(button, [role="button"], input[type="submit"]):disabled {
  opacity: 0.55;
  cursor: not-allowed;
  transform: none;
  box-shadow: 0 10px 24px rgba(212,175,55,0.10);
}

.devis-scope .actions,
.devis-scope .buttons,
.devis-scope .cta-row {
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
  align-items: center;
  justify-content: flex-end;
}
EOF

echo "✅ Done. Now restart dev:"
echo "   Ctrl+C"
echo "   pnpm dev -- --port 5173 --strictPort"
