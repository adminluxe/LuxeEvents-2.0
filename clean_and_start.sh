#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'clean_and_start'. Description à compléter.
echo "✨ Nettoyage des processus sur le port 3000..."

PIDS=$(sudo lsof -ti :3000)
if [ -z "$PIDS" ]; then
  echo "✅ Aucun processus ne tourne sur le port 3000."
else
  echo "⚡ Killing process(s): $PIDS"
  sudo kill -9 $PIDS
  echo "✅ Port 3000 libéré."
fi

echo "🛠️ Relance de l’application avec PM2..."
pm2 start src/server.js --name luxeevents-backend

echo "🎉 Backend Luxeevents démarré avec succès !"
pm2 status luxeevents-backend
