#!/usr/bin/env bash
set -euo pipefail

# ============================================
# TONTON CLEANUP
# - ignore backups/.bak/_archive
# - retire du tracking git (sans effacer tes fichiers localement)
# - commit "CHORE: repo cleanup"
# ============================================

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { echo "❌ Pas dans un repo git"; exit 1; }

add_ignore_line() {
  local line="$1"
  grep -qxF "$line" .gitignore 2>/dev/null || echo "$line" >> .gitignore
}

touch .gitignore

echo "==> 1) Patch .gitignore (anti-pollution)"
add_ignore_line ""
add_ignore_line "# --- TONTON: artifacts / backups (auto) ---"
add_ignore_line "_backups/"
add_ignore_line "_backup_*/"
add_ignore_line "_backup_*/**"
add_ignore_line "_backup_*"
add_ignore_line "*.bak"
add_ignore_line "*.bak_*"
add_ignore_line "*.bak.*"
add_ignore_line "*.backup"
add_ignore_line "*.backup_*"
add_ignore_line "*.orig"
add_ignore_line "*.swp"
add_ignore_line "*.tmp"
add_ignore_line "dist/"
add_ignore_line "node_modules/"
add_ignore_line "src/components/_archive/"

echo "==> 2) Untrack tout ce qui est déjà commité (sans supprimer localement)"
# On cible précisément les fichiers nuisibles déjà suivis.
tracked="$(git ls-files | grep -E '(^_backup_|^_backups/|\.bak($|[_\.])|^src/components/_archive/|^index\.html\.bak|^src/main\.jsx\.bak)' || true)"
if [ -n "${tracked}" ]; then
  echo "$tracked" | xargs -r git rm -r --cached
  echo "✅ Untracked: backups/.bak/_archive"
else
  echo "ℹ️ Rien à untrack (déjà clean)"
fi

echo "==> 3) Supprime HashScroll.jsx si plus utilisé (on garde HashScroller)"
if [ -f src/components/HashScroll.jsx ]; then
  # Si HashScroll est référencé ailleurs que son propre fichier -> on le garde
  refs="$(grep -RIn --exclude-dir='node_modules' --exclude-dir='_backups' --exclude-dir='_backup'* 'HashScroll' src | grep -v 'src/components/HashScroll\.jsx' || true)"
  if [ -z "$refs" ]; then
    git rm -f src/components/HashScroll.jsx || true
    echo "✅ HashScroll.jsx retiré (inutile)"
  else
    echo "⚠️ HashScroll encore référencé, je le laisse:"
    echo "$refs"
  fi
fi

echo "==> 4) Commit cleanup"
git add -A
if git diff --cached --quiet; then
  echo "ℹ️ Rien à commit (déjà clean)"
else
  git commit -m "CHORE: ignore backups + remove tracked artifacts"
  echo "✅ Commit cleanup OK"
fi

echo ""
echo "NEXT:"
echo "  - git status"
echo "  - git push -u origin $(git rev-parse --abbrev-ref HEAD)"
