#!/usr/bin/env bash
set -euo pipefail

BR="smoke/vercel-req-$(date +%Y%m%d-%H%M%S)"
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

git fetch origin --prune
git checkout -B "$BR" origin/main || git checkout -b "$BR"

# Petite modif inoffensive (crée/maj un fichier de smoke)
echo "smoke $(date -Is)" >> .gh-smoke
git add .gh-smoke
git commit -m "chore(smoke): verify Vercel-only required check"
git push -u origin "$BR" --force-with-lease

# Ouvre la PR + affiche/observe les checks
TITLE="chore(smoke): verify Vercel-only required check"
gh pr create --title "$TITLE" --body "Juste un test pour confirmer que seul 'Vercel' est requis." --base main || true
gh pr view --web || true
gh pr checks --watch || true
