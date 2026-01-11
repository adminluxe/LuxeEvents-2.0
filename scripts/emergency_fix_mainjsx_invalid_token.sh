#!/usr/bin/env bash
set -euo pipefail

ts="$(date +%Y%m%d-%H%M%S)"
bdir="_backups/${ts}"
mkdir -p "$bdir"

echo "==> Backup main.jsx actuel"
cp -a src/main.jsx "$bdir/main.jsx.current.bak"

echo "==> 1) Tentative: enlever un éventuel BOM (caractère invisible en début de fichier)"
# enlève BOM UTF-8 si présent
sed -i '1s/^\xEF\xBB\xBF//' src/main.jsx || true

echo "==> 2) Check syntax (node --check)"
if node --check src/main.jsx 2>/tmp/mainjsx_check.err; then
  echo "✅ main.jsx OK après nettoyage BOM"
  exit 0
fi

echo "❌ main.jsx toujours cassé. Erreur:"
cat /tmp/mainjsx_check.err || true
echo

echo "==> 3) Restore automatique depuis le backup le plus récent"
# priorités:
# A) src/main.jsx.bak_* (les backups que tu avais déjà)
# B) _backups/** contenant main.jsx*.bak
cand="$(ls -1t src/main.jsx.bak_* 2>/dev/null | head -n 1 || true)"
if [ -z "${cand:-}" ]; then
  cand="$(ls -1t _backups/**/main.jsx*.bak 2>/dev/null | head -n 1 || true)"
fi

if [ -n "${cand:-}" ] && [ -f "$cand" ]; then
  echo "➡️ Restauration depuis: $cand"
  cp -a "$cand" src/main.jsx
  sed -i '1s/^\xEF\xBB\xBF//' src/main.jsx || true
  node --check src/main.jsx
  echo "✅ main.jsx restauré et valide."
  exit 0
fi

echo "⚠️ Aucun backup trouvé. Dernier recours: git checkout"
if [ -d .git ]; then
  echo "➡️ git checkout -- src/main.jsx"
  git checkout -- src/main.jsx
  node --check src/main.jsx
  echo "✅ main.jsx restauré via git."
  exit 0
fi

echo "❌ Impossible de réparer automatiquement. Affiche le fichier:"
echo "   nl -ba src/main.jsx | sed -n '1,160p'"
exit 1
