#!/usr/bin/env bash
set -euo pipefail

for PAGE in About Gallery; do
  FILE="src/pages/${PAGE}.jsx"
  if [ -f "$FILE" ]; then
    echo "ℹ $FILE existe déjà → skip"
    continue
  fi
  echo "📝 Création de $FILE"
  mkdir -p src/pages
  cat > "$FILE" <<JSX
import React from 'react'
import Layout from '@/components/Layout'

export default function ${PAGE}() {
  return (
    <Layout title="${PAGE == 'About' ? 'About LuxeEvents' : 'Galerie'}">
      <section className="px-6 py-12">
        <h1 className="text-3xl font-bold mb-4">${PAGE == 'About' ? 'À propos de LuxeEvents' : 'Galerie'}</h1>
        <p className="mb-6">
          {/* TODO : ajoute ici un contenu raffiné, varié selon la page */}
        </p>
        ${PAGE == 'Gallery' ? '<!-- <Carousel /> sera injecté ici -->' : ''}
      </section>
    </Layout>
  )
}
JSX
done
