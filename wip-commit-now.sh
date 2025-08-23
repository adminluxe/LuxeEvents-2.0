#!/usr/bin/env bash
set -euo pipefail
unalias git 2>/dev/null || true; unset -f git 2>/dev/null || true

BR="$(git rev-parse --abbrev-ref HEAD)"
MSG="${MSG:-chore(wip): park local work safely}"

# si rien n'est stagé, on ne commit pas
if git diff --cached --quiet; then
  echo "Rien de stagé. (utilise 'git add' ou relance la V2 plus bas)"; exit 0
fi

git commit -m "$MSG"
git push -u origin "$BR" --force-with-lease
echo "✓ WIP poussé → $BR"
