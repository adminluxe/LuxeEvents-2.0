#!/usr/bin/env bash
set -euo pipefail

echo "🔒 Accessibilité & Meta…"

# 1) repère le Layout (jsx ou js, quelle que soit la casse)
LAYOUT_FILE=$(find src/components -type f -iname 'layout.*' | grep -E '\.jsx?$' | head -1 || true)
if [[ -z "$LAYOUT_FILE" ]]; then
  echo "⚠ Aucun Layout.{js,jsx} trouvé dans src/components → skip meta injection"
else
  echo "→ Layout détecté : $LAYOUT_FILE"
  # injecte Helmet fallback si manquant
  for TAG in \
    '<meta name="description"' \
    '<meta property="og:url"' \
    '<meta name="twitter:card"'; do

    if ! grep -q "${TAG}" "$LAYOUT_FILE"; then
      sed -i "/<Helmet>/a\\
        ${TAG} />" "$LAYOUT_FILE"
      echo "   • ${TAG%% *} injecté"
    fi
  done
fi

echo
echo "ℹ Pour l’accessibilité, installe manuellement les dépendances :"
echo "    pnpm add -D axe-core jest-axe @testing-library/react @testing-library/jest-dom"
echo "ℹ Puis crée un test a11y (par ex. src/__tests__/a11y.test.jsx) ou utilise ce snippet :"
cat <<'TEST'

/**
 * @jest-environment jsdom
 */
import React from 'react'
import { render } from '@testing-library/react'
import { axe } from 'jest-axe'
import App from '../src/App'

test('App should have no accessibility violations', async () => {
  const { container } = render(<App />)
  const results = await axe(container)
  expect(results).toHaveNoViolations()
})
TEST

echo
echo "✅ a11y & meta tags mis en place (script terminé)."
