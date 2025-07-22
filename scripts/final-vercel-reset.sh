#!/bin/bash

echo "🧼 Rebuild & deploy de luxe..."
vercel --prod --name luxeevents --scope adminluxes-projects

echo "🌐 Rebind domaine..."
vercel domain rm luxeevents.me
vercel domain add luxeevents.me
vercel alias set luxeevents luxeevents.me
