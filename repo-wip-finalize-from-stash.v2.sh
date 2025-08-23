#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

STASH_REF="${STASH_REF:-stash@{0}}"
BR="$(git rev-parse --abbrev-ref HEAD)"
[[ "$BR" =~ ^chore/wip- ]] || BR="chore/wip-$(date +%Y%m%d-%H%M%S)"
MSG="${MSG:-chore(wip): park local work safely}"

echo "→ Cible: $BR | Source stash: $STASH_REF"

git fetch origin --prune
git checkout -B "$BR" origin/main || git checkout -b "$BR"

# Applique le stash s’il existe et si rien n’est stagé
if git stash show -p "$STASH_REF" >/dev/null 2>&1; then
  git stash apply "$STASH_REF" || true
fi

# Liste propre des fichiers à ajouter (modifiés + non suivis), exclus filtrés
FILES="$( (git ls-files -m; git ls-files -o --exclude-standard) \
  | grep -Ev '^(node_modules/|dist/|\.vercel/|\.next/|coverage/|\.turbo/|\.vite/|tmp/|\.pnpm-store/|\.cache/)' \
  | grep -Ev '/?\.env(\.|$)' \
  | sort -u )"

if [ -z "$FILES" ]; then
  echo "Rien à committer (après exclusions)."; exit 0
fi

# Stage sans pathspecs magiques
printf '%s\0' $FILES | xargs -0 git add -- || true

if git diff --cached --quiet; then
  echo "Rien de stagé après filtrage."; exit 0
fi

git commit -m "$MSG"
git push -u origin "$BR" --force-with-lease
echo "✓ WIP commité & poussé → $BR"

# Drop le stash si toujours présent
git stash drop "$STASH_REF" >/dev/null 2>&1 || true
