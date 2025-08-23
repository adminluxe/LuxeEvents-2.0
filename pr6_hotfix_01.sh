#!/usr/bin/env bash
set -euo pipefail

FILE="pr6_rebase_fix.sh"

if ! grep -q 'BASEREMOTE' "$FILE"; then
  echo "✓ Rien à corriger: ${FILE} ne contient plus BASEREMOTE."
else
  echo "• Patch ${FILE} : BASEREMOTE → BASE_REMOTE"
  sed -i 's/${BASEREMOTE}/${BASE_REMOTE}/g' "$FILE"
fi

# petite vérif de syntaxe
bash -n "$FILE"
chmod +x "$FILE"
echo "✓ Patch appliqué et ${FILE} est exécutable."
