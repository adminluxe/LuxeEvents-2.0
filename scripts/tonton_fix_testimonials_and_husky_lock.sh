#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

say(){ printf "%b\n" "$*"; }
ok(){ say "✅ $*"; }
warn(){ say "⚠️  $*"; }
die(){ say "❌ $*"; exit 1; }

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "Pas dans un repo git"

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/${ts}_husky_lock"
mkdir -p "$bdir"

# ------------------------------------------------------------
# 1) FIX: Testimonials.jsx (Adjacent JSX elements)
# ------------------------------------------------------------
F="src/components/Testimonials.jsx"
if [ -f "$F" ]; then
  cp -a "$F" "$bdir/Testimonials.jsx.bak"
  chmod 600 "$bdir/Testimonials.jsx.bak" || true

  # Ajoute <> ... </> dans return( ... ) si pas déjà présent
  python3 - <<'PY'
import re, pathlib, sys
p = pathlib.Path("src/components/Testimonials.jsx")
s = p.read_text(encoding="utf-8")

# Repère return ( ... ); et wrap global si pas déjà "return (<>"
m = re.search(r"return\s*\(\s*<>", s)
if m:
    sys.exit(0)

def repl(match):
    inner = match.group(1)
    return f"return (\n    <>\n{inner}\n    </>\n  );"

# On wrap le contenu global du return(...) ; safe même si déjà 1 seul root
s2, n = re.subn(
    r"return\s*\(\s*([\s\S]*?)\s*\);\s*",
    repl,
    s,
    count=1
)

# Si on n'a pas trouvé le pattern exact, on ne casse rien : on sort avec code 0 mais on prévient via stdout
if n == 0:
    print("NO_MATCH")
    sys.exit(0)

p.write_text(s2, encoding="utf-8")
print("PATCHED")
PY

  if grep -q "NO_MATCH" <(python3 - <<'PY'
import re, pathlib
s = pathlib.Path("src/components/Testimonials.jsx").read_text(encoding="utf-8")
print("NO_MATCH" if not re.search(r"return\s*\(\s*[\s\S]*?\s*\);\s*", s) else "OK")
PY
); then
    warn "Testimonials.jsx: pattern return(...) non matché -> je n’ai rien modifié automatiquement."
    warn "Affiche le contexte: nl -ba $F | sed -n '1,120p'"
  else
    ok "Testimonials.jsx patché (wrap JSX). Backup: $bdir/Testimonials.jsx.bak"
  fi
else
  warn "Fichier absent: $F (skip)"
fi

# ------------------------------------------------------------
# 2) Mini HUSKY PRE-COMMIT: bloque backups + doublons IDs
# ------------------------------------------------------------
# Husky déjà actif (vu ton pre-push). On ajoute/force pre-commit.

mkdir -p .husky
if [ ! -f .husky/_/husky.sh ]; then
  warn "Husky hook base introuvable (.husky/_/husky.sh)."
  warn "Si husky est installé, lance: pnpm -s husky install"
fi

cat > .husky/pre-commit <<'HOOK'
#!/usr/bin/env sh
. "$(dirname "$0")/_/husky.sh"

set -eu

# 1) Bloque artifacts/backups en staging
staged="$(git diff --cached --name-only || true)"
if echo "$staged" | grep -E '(^_backups/|^_backup_|\.bak($|[_\.])|^src/components/_archive/)' >/dev/null 2>&1; then
  echo "❌ PRE-COMMIT BLOQUÉ: backups/.bak/_archive détectés dans le commit:"
  echo "$staged" | grep -E '(^_backups/|^_backup_|\.bak($|[_\.])|^src/components/_archive/)' || true
  echo "➡️  Retire-les du staging: git reset HEAD <fichier>  (ou supprime-les du commit)"
  exit 1
fi

# 2) IDs uniques (les ancres critiques)
#    On exclut node_modules, dist, _backups, _archive
check_ids="top services realisations temoignages"

for id in $check_ids; do
  # grep peut échouer si rien -> on met || true
  count="$(grep -RIn --exclude-dir=node_modules --exclude-dir=dist --exclude-dir=_backups --exclude-dir=_backup_* --exclude-dir=_archive 'id="'"$id"'"' src 2>/dev/null | wc -l | tr -d ' ')"
  if [ "${count:-0}" -ne 1 ]; then
    echo "❌ PRE-COMMIT BLOQUÉ: id=\"$id\" doit exister 1 seule fois. Actuel: $count"
    grep -RIn --exclude-dir=node_modules --exclude-dir=dist --exclude-dir=_backups --exclude-dir=_backup_* --exclude-dir=_archive 'id="'"$id"'"' src 2>/dev/null || true
    exit 1
  fi
done

echo "✅ PRE-COMMIT OK (no backups, IDs uniques)"
HOOK

chmod +x .husky/pre-commit
ok "Husky pre-commit installé: bloque backups + IDs uniques"

# ------------------------------------------------------------
# 3) Lint rapide (si script lint existe), puis commit auto du fix
# ------------------------------------------------------------
# Commit auto uniquement si diff
if ! git diff --quiet; then
  git add -A

  # Lint si présent (optionnel mais utile)
  if node -e "const p=require('./package.json');process.exit(p.scripts&&p.scripts.lint?0:1)" >/dev/null 2>&1; then
    say "==> Lint: pnpm -s run lint"
    pnpm -s run lint || die "Lint KO (corrige avant push)"
  else
    warn "Pas de script lint détecté -> skip"
  fi

  git commit -m "FIX: Testimonials JSX wrap + pre-commit lock" || true
  ok "Commit fix fait"
else
  ok "Aucun changement à commit"
fi

say ""
say "NEXT:"
say "  git push -u origin $(git rev-parse --abbrev-ref HEAD)"
