#!/bin/bash
echo "🧼 Suppression du cache et relink Vercel..."
vercel --force --prod --yes
