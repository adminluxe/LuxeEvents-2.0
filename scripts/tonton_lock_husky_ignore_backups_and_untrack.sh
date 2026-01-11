#!/usr/bin/env bash
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/${ts}_lock_husky"
mkdir -p "$bdir"

say(){ printf "%b\n" "$*"; }
ok(){ say "✅ $*"; }
warn(){ say "⚠️  $*"; }

# ------------------------------------------------------------
# 1) .gitignore (verrou anti-backups)
# ------------------------------------------------------------
cp -a .gitignore "$bdir/.gitignore.bak" 2>/dev/null || true

add_ignore(){
  local line="$1"
  grep -qxF "$line" .gitignore 2>/dev/null || echo "$line" >> .gitignore
}

touch .gitignore
add_ignore ""
add_ignore "# --- TONTON LOCK: backups/artifacts ---"
add_ignore "_backups/"
add_ignore "_backup_*/"
add_ignore "**/*.bak*"
add_ignore "src/components/_archive/"
add_ignore "src/components/_archive/**"
add_ignore "src/**/._*"
ok ".gitignore verrouillé"

# ------------------------------------------------------------
# 2) Husky pre-commit (ignore backups + IDs uniques)
# ------------------------------------------------------------
mkdir -p .husky
[ -f .husky/pre-commit ] && cp -a .husky/pre-commit "$bdir/pre-commit.bak" || true

cat > .husky/pre-commit <<'HOOK'
#!/usr/bin/env sh
. "$(dirname "$0")/_/husky.sh"

set -eu

# ---- helpers
fail(){ echo "❌ $*"; exit 1; }

# 1) Bloque backups/artifacts SI on les AJOUTE/MODIFIE (les suppressions sont autorisées)
staged_ns="$(git diff --cached --name-status || true)"
# on ne garde que les fichiers dont le statut n'est pas D(eleted)
staged_non_del="$(echo "$staged_ns" | awk '$1!="D"{print $2}' || true)"

if echo "$staged_non_del" | grep -E '(^_backups/|^_backup_|\.bak|^src/components/_archive/)' >/dev/null 2>&1; then
  echo "❌ PRE-COMMIT BLOQUÉ: backups/.bak/_archive détectés dans le staging:"
  echo "$staged_non_del" | grep -E '(^_backups/|^_backup_|\.bak|^src/components/_archive/)' || true
  echo "➡️  Retire-les du staging: git reset HEAD <fichier>"
  exit 1
fi

# 2) IDs uniques (ancres critiques) en ignorant *.bak*
check_ids="top services realisations temoignages"

for id in $check_ids; do
  count="$(grep -RIn \
    --exclude-dir=node_modules --exclude-dir=dist \
    --exclude-dir=_backups --exclude-dir=_archive \
    --exclude='_backup_*' \
    --exclude='*.bak*' \
    'id="'"$id"'"' src 2>/dev/null | wc -l | tr -d ' ')"

  if [ "${count:-0}" -ne 1 ]; then
    echo "❌ PRE-COMMIT BLOQUÉ: id=\"$id\" doit exister 1 seule fois. Actuel: $count"
    grep -RIn \
      --exclude-dir=node_modules --exclude-dir=dist \
      --exclude-dir=_backups --exclude-dir=_archive \
      --exclude='_backup_*' \
      --exclude='*.bak*' \
      'id="'"$id"'"' src 2>/dev/null || true
    exit 1
  fi
done

echo "✅ PRE-COMMIT OK (backups ignorés, IDs uniques OK)"
HOOK

chmod +x .husky/pre-commit
ok "Husky pre-commit verrouillé (ignore backups + check IDs)"

# ------------------------------------------------------------
# 3) Retirer du repo les backups déjà trackés (sans les supprimer localement)
# ------------------------------------------------------------
cp -a /dev/null "$bdir/untracked_list.txt" || true

tracked_bad="$(git ls-files | grep -E '(^_backups/|^_backup_|\.bak|^src/components/_archive/)' || true)"
if [ -n "${tracked_bad:-}" ]; then
  echo "$tracked_bad" > "$bdir/untracked_list.txt"
  echo "$tracked_bad" | xargs -r git rm -r --cached --ignore-unmatch
  ok "Backups/artifacts retirés de l’index git (restent sur ta machine). Liste: $bdir/untracked_list.txt"
else
  ok "Aucun backup/artifact tracké par git (déjà propre)"
fi

# ------------------------------------------------------------
# 4) Commit lock (si nécessaire)
# ------------------------------------------------------------
if ! git diff --cached --quiet || ! git diff --quiet; then
  git add -A
  git commit -m "CHORE: lock husky + ignore/untrack backups (.bak/_backup/_backups/_archive)" || true
  ok "Commit lock OK"
else
  ok "Rien à commit"
fi

say ""
say "NEXT:"
say "  git status"
say "  git push"
