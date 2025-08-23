#!/usr/bin/env bash
set -euo pipefail
OWNER="${OWNER:-adminluxe}"
REPO="${REPO:-LuxeEvents-2.0}"

echo "== Désactivation de 'Cloudflare Pages' dans les Rulesets actifs =="

# Liste les rulesets
mapfile -t IDS < <(gh api -H "Accept: application/vnd.github+json" \
  "/repos/$OWNER/$REPO/rulesets?per_page=100" \
  | jq -r '.[] | select(.enforcement!="disabled") | .id')

if [ ${#IDS[@]} -eq 0 ]; then
  echo "• Aucun ruleset actif trouvé."
  exit 0
fi

CHANGED=0
for ID in "${IDS[@]}"; do
  RS_JSON="$(gh api -H "Accept: application/vnd.github+json" \
    "/repos/$OWNER/$REPO/rulesets/$ID")"

  # Construit les nouvelles 'rules' en supprimant tout contexte contenant "cloudflare" ou "pages"
  NEW_RULES="$(printf '%s' "$RS_JSON" | jq '
    .rules |= (map(
      if .type=="required_status_checks" then
        .parameters.contexts         = ((.parameters.contexts // []) 
                                         | map(select(test("cloudflare|pages";"i")|not)))
        | .parameters.required_checks = ((.parameters.required_checks // []) 
                                         | map(select((.context // "") 
                                                | test("cloudflare|pages";"i")|not)))
        | .parameters.checks          = ((.parameters.checks // []) 
                                         | map(select((.context // "") 
                                                | test("cloudflare|pages";"i")|not)))
        | .
      else . end
    ))
    | .rules
  ')"

  # Compare avant/après pour éviter un PATCH inutile
  ORIG_RULES="$(printf '%s' "$RS_JSON" | jq '.rules')"
  if ! diff -q <(printf '%s\n' "$ORIG_RULES") <(printf '%s\n' "$NEW_RULES") >/dev/null 2>&1; then
    # PATCH minimal: on n’envoie que 'rules'
    printf '%s\n' "{\"rules\": $NEW_RULES }" \
    | gh api -X PATCH -H "Accept: application/vnd.github+json" \
      "/repos/$OWNER/$REPO/rulesets/$ID" \
      --input -
    echo "✓ Ruleset $ID : 'Cloudflare Pages' retiré des required status checks."
    CHANGED=$((CHANGED+1))
  else
    echo "• Ruleset $ID : rien à changer."
  fi
done

if [ "$CHANGED" -eq 0 ]; then
  echo "• Aucun ruleset ne contenait 'Cloudflare Pages' comme check requis."
else
  echo "== Terminé : $CHANGED ruleset(s) mis à jour =="
fi
