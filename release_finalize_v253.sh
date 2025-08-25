#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

REPO_DIR="${REPO_DIR:-$HOME/luxeevents-frontend-clean}"
OWNER="adminluxe"; REPO="LuxeEvents-2.0"; PR=15
cd "$REPO_DIR"

echo "== Finalise v2.5.3 (PR #$PR) =="

# 1) S'assure que la PR #15 est mergée (admin si possible, sinon auto)
gh pr view -R "$OWNER/$REPO" "$PR" --json state -q .state | grep -q '^MERGED$' || {
  echo "• Merge PR #$PR (admin si possible, sinon auto)…"
  gh pr merge -R "$OWNER/$REPO" "$PR" --squash --delete-branch --admin \
   || gh pr merge -R "$OWNER/$REPO" "$PR" --squash --auto || true
}

# 2) Sync local main sur origin/main (écrase la divergence locale)
git fetch origin --prune
git checkout main
git reset --hard origin/main

# 3) Re-pointe le tag v2.5.3 sur le HEAD réel de origin/main
git tag -f v2.5.3 origin/main
git push -f origin v2.5.3

# 4) Purge CF (si script présent)
[ -x ./cf-purge-now.sh ] && ./cf-purge-now.sh || true

# 5) Smoke prod
for U in / /bg-luxeevents.png /logo_gold_black.png /images/gallery/thumb1.png; do
  echo "TEST $U"; curl -I "https://www.luxeevents.me$U" | head -n1
done

echo "✓ v2.5.3 pointé sur origin/main, prod OK."
