#!/usr/bin/env bash
# overwrite_home_i18n.sh — Réécrase Home.jsx pour features & services i18n sûrs
set -euo pipefail

FILE="src/pages/Home.jsx"
if [[ ! -f "$FILE" ]]; then
  echo "❌ $FILE introuvable !"
  exit 1
fi

cat > "$FILE" << 'COMP'
import React from 'react'
import { useTranslation } from 'react-i18next'
import Layout from '@/components/Layout'

export default function Home() {
  const { t } = useTranslation()

  // Features et Services déclarés comme tableaux
  const features = t('home.features',   { returnObjects: true })
  const services = t('home.services',   { returnObjects: true })

  return (
    <Layout title={t('home.title')}>
      <section>
        {Array.isArray(features) ? (
          features.map((f, i) => (
            <div key={i}>
              <h2>{f.title}</h2>
              <p>{f.desc}</p>
            </div>
          ))
        ) : null}
      </section>

      <section>
        <h3>{t('home.servicesTitle')}</h3>
        <ul>
          {Array.isArray(services) ? (
            services.map((s, i) => <li key={i}>{s}</li>)
          ) : null}
        </ul>
      </section>
    </Layout>
  )
}
COMP

echo "✅ Home.jsx réécrit avec i18n sécurisé."
