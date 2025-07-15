#!/usr/bin/env bash
set -euo pipefail

COMP="src/components/Layout.jsx"
if [ -f "$COMP" ]; then
  echo "ℹ $COMP existe déjà, skip"
  exit 0
fi

mkdir -p src/components

cat > "$COMP" <<'COMP'
import React from 'react'
import { Helmet } from 'react-helmet'

export default function Layout({ title = '', children }) {
  return (
    <>
      <Helmet>
        <title>{title ? `${title} · LuxeEvents` : 'LuxeEvents'}</title>
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <meta name="description" content="LuxeEvents — Orchestration d’événements élégants et accessibles" />
        {/* OG / Twitter */}
        <meta property="og:title" content={title ? `${title} · LuxeEvents` : 'LuxeEvents'} />
        <meta property="og:description" content="LuxeEvents — Orchestration d’événements élégants et accessibles" />
        <meta name="twitter:card" content="summary_large_image" />
      </Helmet>
      <div className="min-h-screen flex flex-col">
        <main className="flex-1">
          {children}
        </main>
        {/* footer éventuel */}
      </div>
    </>
  )
}
COMP

echo "✅ Composant Layout généré dans $COMP"
