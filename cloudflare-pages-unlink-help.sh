#!/usr/bin/env bash
set -euo pipefail
echo "Ouvre (GitHub Apps installés) : https://github.com/settings/installations"
echo "→ Cherche “Cloudflare Pages” > Configure > switch sur 'Only select repositories' > décoche 'LuxeEvents-2.0'."
echo
echo "Côté Cloudflare (Pages) : https://dash.cloudflare.com/"
echo "→ Pages > (projet lié) > Settings > Git > Disconnect Repository"
echo
echo "Après déconnexion, de nouvelles PRs n’auront plus le check 'Cloudflare Pages'."
