#!/usr/bin/env bash
# fix_all.sh — cleanup, i18n, Home.jsx, events, Map.jsx & future flags
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "🚀 Démarrage du gros script dans $ROOT"

# 1) Purge node_modules et cache Vite
echo "🔄 Purge node_modules & cache Vite…"
rm -rf node_modules node_modules/.vite pnpm-lock.yaml

# 2) Réinstall sans blocage par frozen-lockfile
echo "📦 Réinstallation (no-frozen-lockfile)…"
pnpm install --no-frozen-lockfile

# 3) Normalisation des JSON de traduction
echo "🌐 Normalisation i18n JSON"
for FILE in \
  public/locales/fr/fr.json \
  public/locales/en/en.json \
  src/locales/fr.json \
  src/locales/en.json; do
  if [[ -f "$FILE" ]]; then
    echo " - Traitement $FILE"
    tmp="$FILE.tmp"
    jq '
      .home += {
        title:         (.home.title         // "Accueil"),
        intro:         (.home.intro         // ""),
        features:      (if .home.features  | type=="array" then .home.features  else [] end),
        services:      (if .home.services  | type=="array" then .home.services  else [] end),
        servicesTitle: (.home.servicesTitle // "Services"),
        mapTitle:      (.home.mapTitle      // "Nos événements")
      } |
      del(.servicesTitle, .mapTitle)
    ' "$FILE" > "$tmp" && mv "$tmp" "$FILE"
  fi
done

# 4) Patch Home.jsx (returnObjects + sécurisation map)
echo "🏠 Patch src/pages/Home.jsx"
HOMEPAGE="src/pages/Home.jsx"
if [[ -f "$HOMEPAGE" ]]; then
  sed -i \
    -e "s|const features = t('home.features');|const features = t('home.features', { returnObjects: true });|" \
    -e "/const features =/a \  const services = t('home.services', { returnObjects: true });" \
    -e "s|{features\.map|{Array.isArray(features) ? features.map|g" \
    -e "s|{services\.map|{Array.isArray(services) ? services.map|g" \
    -e "s|))}|)) : null}|g" \
    "$HOMEPAGE"
fi

# 5) Inject dates in events.js
echo "📅 Mise à jour src/data/events.js"
EVENTS="src/data/events.js"
if [[ -f "$EVENTS" ]]; then
  cat > "$EVENTS" <<'JS'
export const eventsData = [
  {
    title: 'Salon Luxe 2025',
    description: 'Exposition annuelle des fournisseurs premium',
    date: 'Décembre 2025',
    lat: 48.8566, lng: 2.3522,
  },
  {
    title: 'Conférence Design',
    description: 'Rencontre des designers événementiels',
    date: 'Septembre 2025',
    lat: 48.8606, lng: 2.3376,
  },
  {
    title: 'The Mariage',
    description: 'Cérémonie & réception d’exception',
    date: 'Fin Novembre 2025',
    lat: 48.8584, lng: 2.2945,
  },
];
JS
fi

# 6) Update Map.jsx popup
echo "🗺️  Patch src/components/Map.jsx"
MAPC="src/components/Map.jsx"
if [[ -f "$MAPC" ]]; then
  sed -i "/<Popup>/,/<\/Popup>/c\\
            <Popup>\\
              <strong>{evt.title}</strong><br/>\\
              {evt.description}<br/>\\
              <em>{evt.date}</em>\\
            </Popup>" "$MAPC"
fi

# 7) Future flags React Router
echo "🔮 Ajout future flags dans src/main.jsx"
MAIN="src/main.jsx"
if [[ -f "$MAIN" ]]; then
  sed -i -E \
    -e "/createBrowserRouter\(/,/\)/ s|(\[)|{ future: { v7_startTransition: true, v7_relativeSplatPath: true } }, [|g" \
    -e "s|<RouterProvider router=\{([^}]+)\}|<RouterProvider router={\1} future={{ v7_startTransition: true, v7_relativeSplatPath: true }}|g" \
    "$MAIN"
fi

# 8) Purge cache Vite final
echo "🧹 Nettoyage final du cache Vite…"
rm -rf node_modules/.vite

echo "✅ Tout est prêt ! Lancez maintenant : pnpm run dev"
