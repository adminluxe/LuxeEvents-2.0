#!/usr/bin/env bash
set -euo pipefail
OWNER="${OWNER:-adminluxe}"
REPO="${REPO:-LuxeEvents-2.0}"

echo "== Liste des Rulesets actifs et leurs checks requis =="
gh api -H "Accept: application/vnd.github+json" \
  "/repos/$OWNER/$REPO/rulesets?per_page=100" \
| jq -r '
  .[] 
  | select(.enforcement!="disabled") 
  | {
      id, name, enforcement, target:.target, conditions, rules
    }
  ' \
| jq -r '
  "— ID: \(.id) | Name: \(.name) | Enforcement: \(.enforcement) | Target: \(.target)\n" +
  (if (.conditions.ref_name.include // [])|length>0 then
     "   Refs: \((.conditions.ref_name.include)|join(", "))\n"
   else "" end) +
  (
    ( .rules // [] )
    | map(select(.type=="required_status_checks"))
    | if length==0 then "   (no required_status_checks rule)\n"
      else
        ( .[] 
          | "   required_status_checks:\n"
            + ( "     contexts: "
                + ( ((.parameters.contexts // [])|length>0) 
                    as $n | 
                    (if $n>0 then ((.parameters.contexts // [])|join(", ")) else "—" end) ) + "\n" )
            + ( "     required_checks: "
                + ( ((.parameters.required_checks // [])|length>0) 
                    as $m |
                    (if $m>0 then ( (.parameters.required_checks // []) | map(.context) | join(", ") ) else "—" end) ) + "\n" )
            + ( "     checks: "
                + ( ((.parameters.checks // [])|length>0) 
                    as $k |
                    (if $k>0 then ( (.parameters.checks // []) | map(.context) | join(", ") ) else "—" end) ) + "\n" )
        )
      end
  )
'
echo "== Fin =="
