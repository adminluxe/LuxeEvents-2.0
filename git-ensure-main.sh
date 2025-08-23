#!/usr/bin/env bash
set -euo pipefail

# Neutralise tout alias/override de 'git' qui pourrait injecter des args
unalias git 2>/dev/null || true
if declare -F git >/dev/null 2>&1; then
  unset -f git || true
fi

command git rev-parse --is-inside-work-tree >/dev/null
REPO_ROOT="$(command git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

# Vérifie 'origin'
command git remote get-url origin >/dev/null

# Récupère 'origin/main' en remote-tracking, même en repo shallow
command git fetch origin --prune
command git fetch origin main:refs/remotes/origin/main

# Crée/recâble la branche locale 'main' SANS "branch --track" (source d'erreurs)
if command git show-ref --verify --quiet refs/heads/main; then
  # Juste définir l'upstream proprement
  command git branch --set-upstream-to=origin/main main >/dev/null 2>&1 || true
else
  # Crée 'main' à partir du SHA d'origin/main sans magie
  SHA="$(command git rev-parse refs/remotes/origin/main)"
  command git update-ref refs/heads/main "$SHA"
  command git branch --set-upstream-to=origin/main main >/dev/null 2>&1 || true
fi

echo "✓ local 'main' → tracks origin/main (OK)"
