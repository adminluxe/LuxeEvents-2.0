#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Démarrage du script de mise à jour..."

### 1) EVENTS DATA
EVENTS_FILE="src/data/events.js"
echo "🔧 Mise à jour des dates dans $EVENTS_FILE…"

# On remplace la Conférence Design avec date septembre
sed -i "/Conférence Design/ s|}$|, date: '2025-09-15' }|g" $EVENTS_FILE

# On ajoute "The Mariage" fin novembre et "Salon Luxe 2025" en décembre
# Vérifie qu'ils n'y sont pas déjà
grep -q "The Mariage" $EVENTS_FILE || sed -i "/];/i \
  { title: 'The Mariage', description: 'Célébration d’exception', lat: 48.853, lng: 2.349, date: '2025-11-25' },\
" $EVENTS_FILE

grep -q "Salon Luxe 2025" $EVENTS_FILE || sed -i "/];/i \
  { title: 'Salon Luxe 2025', description: 'Exposition annuelle des fournisseurs premium', lat: 48.8566, lng: 2.3522, date: '2025-12-05' },\
" $EVENTS_FILE

echo "✅ Dates injectées."

### 2) HOME.JSX
HOME="src/pages/Home.jsx"
MAP_COMP="import Map from '@/components/Map'"
echo "🔧 Mise à jour de $HOME…"

# 2.1 On ajoute l'import de la Map si nécessaire
grep -q "import Map" $HOME || sed -i "1s|$|\\n$MAP_COMP|" $HOME

# 2.2 On injecte la section Map juste après la section services
#    en utilisant mapTitle de la i18n
sed -i "/<\/section>/a \
\
      <section style={{ marginTop: '2rem' }}>\
        <h3>{t('home.mapTitle')}</h3>\
        <Map events={eventsData} />\
      </section>\
" $HOME

# 2.3 On ajoute l'import de eventsData dans Home.jsx
grep -q "eventsData" $HOME || sed -i "/import Map/a \
import { eventsData } from '@/data/events'" $HOME

# 2.4 On remplace le popup existant dans Map.jsx pour afficher title/description/date
MAP="src/components/Map.jsx"
echo "🔧 Mise à jour du popup dans $MAP…"
sed -i "/<Popup>/,/<\\/Popup>/c\\
            <Popup>\\
              <strong>{evt.title}</strong><br />\\
              {evt.description}<br />\\
              <em>{evt.date}</em>\\
            </Popup>" $MAP

echo "✅ Home.jsx et Map.jsx mis à jour."

### 3) INSTALL & BUILD
echo "🔄 Réinstallation rapide des dépendances (lockfile mis à jour)…"
pnpm install --no-frozen-lockfile

echo "🧹 Nettoyage du cache Vite…"
rm -rf node_modules/.vite

echo "🎉 Tout est prêt ! Lancement du dev server…"
pnpm run dev
