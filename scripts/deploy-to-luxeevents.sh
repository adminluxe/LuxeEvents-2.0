#!/bin/bash
echo "📦 Build + Deploy LuxeEvents en prod sur https://luxeevents.me"
pnpm run build
vercel --prod --scope adminluxes-projects
