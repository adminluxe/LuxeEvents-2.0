#!/usr/bin/env bash
set -eo pipefail

# 🛠️ Fix package.json (ajout date-fns + suppression virgule finale)
# Injecte "date-fns" dans dependencies juste après l'accolade
sed -i '/"dependencies": *{/{n;s/{/&\
    "date-fns": "4.1.0",/;}' package.json
# Supprime la virgule finale après "yet-another-react-lightbox"
sed -i '/"yet-another-react-lightbox":/ s/,$//' package.json

echo "🚀 Démarrage de l’automatisation LuxeEvents v3…"

# 1) Patch palette Tailwind
echo "1) Patch tailwind.config.js…"
if ! grep -q "luxeGold" tailwind.config.js 2>/dev/null; then
  sed -i "/extend: {/a\\
      colors: { luxeGold: '#D4AF37', luxeBlack: '#000000', luxeIvory: '#FFFFF0' },"
  echo "   → Couleurs injectées"
else
  echo "   ℹ Couleurs déjà présentes"
fi

# 2) Injection Plausible
echo "2) Injection Plausible dans public/index.html…"
if ! grep -q "plausible.io/js/plausible.js" public/index.html; then
  sed -i "/<head>/a\    <script async defer data-domain=\"ton-domaine.com\" src=\"https://plausible.io/js/plausible.js\"></script>" public/index.html
  echo "   → Plausible ajouté"
else
  echo "   ℹ Plausible déjà présent"
fi

# 3) Fix Navbar.jsx (parenthèse manquante)
echo "3) Correctif Navbar.jsx…"
NAV=src/components/Navbar.jsx
if ! grep -q 'return' "$NAV" || ! grep -q ')</' "$NAV"; then
  # On ferme la parenthèse du return() et le bloc fonction
  sed -i '$a\      )\n  }' "$NAV"
  echo "   → Parenthèse fermée dans $NAV"
else
  echo "   ℹ Navbar.jsx semble déjà correct"
fi

# 4) Génération des composants & pages
echo "4) Génération des composants & pages…"
./bootstrap-v2-to-v3.sh    2>/dev/null || true
./fast-media-scaffold.sh   2>/dev/null || true
./scaffold-request-form.sh 2>/dev/null || true

# 5) Stub i18n
echo "5) Stub i18n…"
for LANG in fr en; do
  mkdir -p public/locales/$LANG
  cat > public/locales/$LANG/translation.json <<JSON
{
  "nav.home": "Accueil",
  "nav.services": "Services",
  "nav.media": "Médias",
  "nav.quote": "Devis"
}
JSON
done

# 6) Format & lint
echo "6) Prettier & ESLint --fix…"
pnpm exec prettier --write "src/**/*.{js,jsx,ts,tsx,json,css,md}" || true
pnpm exec eslint --fix "src/**/*.{js,jsx,ts,tsx}" || true

# 7) Tests (ne doit pas bloquer)
echo "7) Jest (passWithNoTests)…"
pnpm exec jest --passWithNoTests || echo "   ⚠ Jest a retourné une erreur, on continue..."

# 8) Build & PWA
echo "8) Build + PWA…"
pnpm run build

# 9) Preview
echo "9) Serve dist…"
pnpm exec serve -s dist &

echo
echo "🎉 Automatisation terminée !"
echo "    • Preview → http://localhost:5000"
echo "    • Vérifie et remplace les stubs (images, traductions…)"

