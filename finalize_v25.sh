#!/usr/bin/env bash
set -euo pipefail

BRANCH="${1:-v2-5-fresh}"
ENABLE_SW="${ENABLE_SW:-0}"   # mets ENABLE_SW=1 pour réactiver le SW

echo "== finalize_v25: branch=$BRANCH, ENABLE_SW=$ENABLE_SW =="

root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "${root}" ]]; then
  echo "❌ Pas dans un dépôt git."; exit 1
fi
cd "$root"

# --- 1) Sécu branche ---
current="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$current" != "$BRANCH" ]]; then
  echo "→ Checkout $BRANCH"
  git checkout "$BRANCH"
fi

# --- 2) Patch ServicesSection.jsx ---
SS="src/components/ServicesSection.jsx"
if [[ -f "$SS" ]]; then
  echo "→ Patch $SS (import * as S + fallback const services)"
  # Unifie l'import depuis services.luxe.js
  if grep -Eq "from ['\"]/\.{0,2}/data/services\.luxe\.js['\"]" "$SS"; then
    sed -i -E \
      "s|^import[[:space:]]+[^;]*from[[:space:]]+['\"]/\.{0,2}/data/services\.luxe\.js['\"];?|import * as S from '../data/services.luxe.js';|g" \
      "$SS"
  fi
  # Ajoute le fallback const services (si absent)
  if ! grep -q "const services = S\.services" "$SS"; then
    # insère juste après l'import vers services.luxe.js
    awk '
      BEGIN{done=0}
      {
        print $0
        if(!done && $0 ~ /import \* as S from..\/data\/services\.luxe\.js.;/){
          print "const services = S.services || S.default || S.luxeServices || S.data || [];";
          done=1
        }
      }' "$SS" > "$SS.tmp" && mv "$SS.tmp" "$SS"
  fi
else
  echo "ℹ️  $SS introuvable, on passe."
fi

# --- 3) (Optionnel) Réactivation du Service Worker ---
if [[ "$ENABLE_SW" == "1" ]]; then
  if [[ -f "index.html" ]]; then
    echo "→ Réactivation SW dans index.html"
    # Retire le 'false&&' que nous avions injecté
    sed -i 's/false&&[[:space:]]*//g' index.html || true
  fi
else
  echo "ℹ️  SW inchangé (ENABLE_SW=0)."
fi

# --- 4) Sanity check: plugin-react & jsxInject déjà patchés via hotfix ---
if [[ -f "vite.config.mjs" ]]; then
  if ! grep -q "@vitejs/plugin-react" vite.config.mjs; then
    echo "⚠️  @vitejs/plugin-react non détecté dans vite.config.mjs (mais build précédent OK)."
  fi
  if ! grep -q "jsxInject" vite.config.mjs; then
    echo "⚠️  jsxInject non détecté dans vite.config.mjs."
  fi
fi

# --- 5) Build local ---
echo "→ Build local (vite)"
pnpm build

# --- 6) Commit & push ---
git add -A
git commit -m "chore(v2.5): fix ServicesSection import + optional SW re-enable" || true
git push -u origin "$BRANCH"

echo "✓ Done. La PR sera mise à jour automatiquement."
echo "   Si tu veux réactiver le Service Worker : ENABLE_SW=1 ./finalize_v25.sh"
