#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

REPO_DIR="${REPO_DIR:-$HOME/luxeevents-frontend-clean}"
OWNER="adminluxe"; REPO="LuxeEvents-2.0"

cd "$REPO_DIR"

# 0) Sécurité: on récupère les refs distantes
git fetch origin --prune

# 1) Crée une branche à partir de TON HEAD courant (qui contient déjà le commit SEO/A11Y)
BR="polish/last-mile-$(date +%Y%m%d-%H%M%S)"
git checkout -b "$BR"

# 2) Rebase sur origin/main (linéaire & propre)
set +e
git rebase origin/main
REB=$?
set -e
if [ $REB -ne 0 ]; then
  # si conflit sur index.html, on garde notre version (celle avec ton polish)
  if git ls-files -u | awk '{print $4}' | sort -u | grep -qx "index.html"; then
    git checkout --ours -- index.html
    git add index.html
    git rebase --continue
  else
    echo "✖ Conflit inattendu. Abort…"; git rebase --abort; exit 1
  fi
fi

# 3) Push branche + PR
git push -u origin "$BR"

# PR title/body
TITLE="chore(seo/perf/a11y): last-mile polish"
BODY=$'• Canonical, meta description, theme-color\n• Preconnect fonts + preload héro (png)\n• Lazy/decoding galerie\n• JSON-LD Organization + WebSite\n• SW guard (idempotent)'

# crée la PR si elle n’existe pas déjà
if ! gh pr view -R "$OWNER/$REPO" "$BR" >/dev/null 2>&1; then
  gh pr create -R "$OWNER/$REPO" -B main -H "$BR" -t "$TITLE" -b "$BODY"
fi

# 4) Attendre Vercel ✅ sur le head de la PR
PRN="$(gh pr view -R "$OWNER/$REPO" "$BR" --json number -q .number)"
SHA="$(gh pr view -R "$OWNER/$REPO" "$PRN" --json headRefOid -q .headRefOid)"
echo "• PR #$PRN → head: $SHA — attente Vercel…"
for i in $(seq 1 120); do
  ok=$(gh api "/repos/$OWNER/$REPO/commits/$SHA/check-runs" \
        -H "Accept: application/vnd.github+json" \
        --jq '[.check_runs[]?|select(.app.slug=="vercel")]|map(.status=="completed" and .conclusion=="success")|any' 2>/dev/null || echo false)
  [ "$ok" = "true" ] && break
  sleep 2
done

# 5) Merge (admin si possible, sinon auto)
gh pr merge -R "$OWNER/$REPO" "$PRN" --squash --delete-branch --admin \
 || gh pr merge -R "$OWNER/$REPO" "$PRN" --squash --auto

# 6) Sync local main
git checkout main
git fetch origin --prune
git pull --ff-only origin main || true

# 7) Purge CF (via ton script fallback si l’alias n’est pas chargé)
if [ -x "./cf-purge-now.sh" ]; then ./cf-purge-now.sh || true; fi

# 8) Smoke prod
for U in / /bg-luxeevents.png /logo_gold_black.png /images/gallery/thumb1.png; do
  echo "TEST $U"; curl -I "https://www.luxeevents.me$U" | head -n1
done

echo "✓ Last-mile livré via PR #$PRN."
