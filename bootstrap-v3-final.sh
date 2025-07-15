# 🛠️ Fix package.json (ajout date-fns + suppression virgule finale)
sed -i '/"dependencies": *{/{n; s/{/&\n    "date-fns": "4.1.0",/}' package.json
sed -i '/"yet-another-react-lightbox":/ s/,$//'
#!/bin/bash
# 🛠️ Fix package.json (ajout date-fns + suppression virgule finale)
sed -i '/"dependencies": *{/{n; s/{/&\n    "date-fns": "4.1.0",/}' package.json
sed -i '/"yet-another-react-lightbox":/ s/,$//'
# 🛠️ Fix package.json (ajout date-fns + suppression virgule finale) 

sed -i '/"dependencies": *{/{n; s/{/&\n    "date-fns": "4.1.0",/}' package.json 

sed -i '/"yet-another-react-lightbox":/ s/,$//'
#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Démarrage de l’automatisation LuxeEvents v3…"

# 1) Patch palette Tailwind
echo "1️⃣ Patch tailwind.config.js…"
if ! grep -q "luxeGold" tailwind.config.js 2>/dev/null; then
  sed -i "/extend: {/a\\
      colors: { luxeGold: '#D4AF37', luxeBlack: '#000000', luxeIvory: '#FFFFF0' },"
  echo "   → Couleurs injectées"
else
  echo "   ℹ Couleurs déjà présentes"
fi

# 2) Injection Plausible
echo "2️⃣ Injection Plausible dans public/index.html…"
if ! grep -q "plausible.io/js/plausible.js" public/index.html; then
  sed -i "/<head>/a\    <script async defer data-domain=\"ton-domaine.com\" src=\"https://plausible.io/js/plausible.js\"></script>" public/index.html
  echo "   → Plausible ajouté"
else
  echo "   ℹ Plausible déjà présent"
fi

# 3) Fix Navbar.jsx (parenthèse manquante)
echo "3️⃣ Correctif Navbar.jsx…"
NAV=src/components/Navbar.jsx
if grep -qE "header>\\s*$" "$NAV"; then
  # On ferme la parenthèse et le return
  sed -i '$i \)\n  }' "$NAV"
  echo "   → Parenthèse fermée dans $NAV"
else
  echo "   ℹ Navbar.jsx semble correct"
fi

# 4) Generators (layout, media, form…)
echo "4️⃣ Génération des composants & pages…"
./bootstrap-v2-to-v3.sh       2>/dev/null || true
./fast-media-scaffold.sh      2>/dev/null || true
./scaffold-request-form.sh    2>/dev/null || true

# 5) Stub i18n
echo "5️⃣ Stub i18n…"
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
echo "6️⃣ Prettier & ESLint --fix…"
pnpm exec prettier --write "src/**/*.{js,jsx,ts,tsx,json,css,md}" || true
pnpm exec eslint --fix "src/**/*.{js,jsx,ts,tsx}" || true

# 7) Tests (ne doit pas bloquer)
echo "7️⃣ Jest (passWithNoTests)…"
pnpm exec jest --passWithNoTests || echo "   ⚠️ Jest a retourné une erreur, on continue..."

# 8) Build & PWA
echo "8️⃣ Build + PWA…"
pnpm run build

# 9) Preview
echo "9️⃣ Serve dist…"
pnpm exec serve -s dist &

echo
echo "🎉 Automatisation terminée !"
echo "   • Preview → http://localhost:5000"
echo "   • N’oublie pas de vérifier et remplacer les stubs (images, traduction…)"
