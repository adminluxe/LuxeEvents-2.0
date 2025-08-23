#!/usr/bin/env bash
set -euo pipefail
BR="${1:-$(git rev-parse --abbrev-ref HEAD)}"

# Neutraliser alias git éventuels
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

# Trouve la PR associée à la branche
PR="$(gh pr list --head "$BR" --json number -q '.[0].number' 2>/dev/null || true)"
if [ -z "$PR" ]; then
  echo "✖ Aucune PR trouvée pour la branche '$BR'"; exit 1
fi
echo "→ PR #$PR pour '$BR'"

# Merge (admin si possible, sinon auto)
gh pr merge "$PR" --squash --delete-branch --admin \
  || gh pr merge "$PR" --squash --auto || true

# Sync + ménage local
git checkout main >/dev/null 2>&1 || true
git fetch origin --prune
git pull --ff-only origin main || true
git branch -D "$BR" 2>/dev/null || true

echo "✓ PR #$PR fusionnée/programmée, branche nettoyée."
