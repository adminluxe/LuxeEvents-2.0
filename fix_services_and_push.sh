#!/usr/bin/env bash
set -euo pipefail

BRANCH="${1:-v2-5-fresh}"

echo "== fix_services_and_push: branch=$BRANCH =="

# --- Sécu: sur la bonne branche
git rev-parse --is-inside-work-tree >/dev/null
cur="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$cur" != "$BRANCH" ]]; then
  git checkout "$BRANCH"
fi

F="src/components/ServicesSection.jsx"
if [[ -f "$F" ]]; then
  echo "→ Patch $F (import * as S + fallback const services)"
  cp -n "$F" "$F.bak.$(date +%Y%m%d-%H%M%S)" || true

  awk '
    BEGIN { did=0 }
    # Toute ligne d import depuis services.luxe.js
    $0 ~ /^[[:space:]]*import[[:space:]].*from[[:space:]]*["'\''"].*services\.luxe\.js["'\''"][[:space:]]*;[[:space:]]*$/ {
      if (!did) {
        print "import * as S from \"../data/services.luxe.js\";";
        print "const services = S.services || S.default || S.luxeServices || S.data || [];";
        did=1;
      }
      next; # on supprime l import original
    }
    { print $0 }
    END {
      if (!did) {
        print "import * as S from \"../data/services.luxe.js\";";
        print "const services = S.services || S.default || S.luxeServices || S.data || [];";
      }
    }
  ' "$F" > "$F.tmp" && mv "$F.tmp" "$F"
else
  echo "⚠️  $F introuvable — rien à patcher."
fi

echo "→ Build…"
pnpm build

git add "$F" 2>/dev/null || true
git commit -m "fix(ServicesSection): robust import of services.luxe.js (any export shape)" || true

echo "→ Push…"
if ! git push origin "$BRANCH"; then
  echo "SSH a échoué, bascule sur HTTPS et retente…"
  git remote set-url origin "https://github.com/adminluxe/LuxeEvents-2.0.git"
  git push -u origin "$BRANCH"
fi

echo "✓ OK. La PR sera mise à jour (branche $BRANCH)."
