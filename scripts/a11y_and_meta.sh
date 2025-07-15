#!/usr/bin/env bash
set -euo pipefail

echo "🔒 Accessibilité & Meta…"

# 1) recherche automatique du Layout dans src/components
LAYOUT_FILE=$(find src/components -type f -iname 'layout.*' | grep -E '\.jsx?$' | head -1 || true)
if [[ -z "$LAYOUT_FILE" ]]; then
  echo "⚠ Aucun Layout.{js,jsx} trouvé dans src/components → skip meta injection"
else
  echo "→ Layout détecté : $LAYOUT_FILE"
  # liste des balises à injecter
  for TAG in \
    '<meta name=\"description\" content={description} \\/>' \
    '<meta property=\"og:url\" content={window.location.href} \\/>' \
    '<meta name=\"twitter:card\" content=\"summary_large_image\" \\/>'; do

    if ! grep -q "${TAG%% *}" "$LAYOUT_FILE"; then
      sed -i "/<Helmet>/a\\
      ${TAG}" "$LAYOUT_FILE"
      echo "   • ${TAG%% *} injecté"
    fi
  done
fi

echo
echo "ℹ Pour l’accessibilité, installe manuellement les dépendances :"
echo "    pnpm add -D axe-core jest-axe @testing-library/react @testing-library/jest-dom"
echo
echo "ℹ Voici un exemple de test a11y à placer dans src/__tests__/a11y.test.jsx :"
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
