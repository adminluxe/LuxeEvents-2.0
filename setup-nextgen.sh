#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Démarrage du setup Next-Gen à la Tonton…"

# 1) i18n : react-i18next setup
echo "1) Installation react-i18next & i18next…"
npm install react-i18next i18next --save
echo "   → Création de src/i18n.js…"
tee src/i18n.js > /dev/null << 'EOF'
import i18n from 'i18next'
import { initReactI18next } from 'react-i18next'

const resources = {
  fr: {
    translation: {
      "Nos Prestations": "Nos Prestations",
      "Contactez-nous": "Contactez-nous",
      // ajoute ici tes clés/traductions
    }
  },
  en: {
    translation: {
      "Nos Prestations": "Our Services",
      "Contactez-nous": "Contact Us",
      // ajoute ici tes clés/traductions
    }
  }
}

i18n
  .use(initReactI18next)
  .init({
    resources,
    lng: 'fr',
    fallbackLng: 'en',
    interpolation: { escapeValue: false }
  })

export default i18n
EOF

echo "   → Wrap App avec I18nextProvider dans src/main.jsx…"
sed -i '/import { BrowserRouter/a import "./i18n"' src/main.jsx

# 2) Meta Open Graph & Twitter Cards
echo "2) Injection des meta OG & Twitter Cards dans Layout.jsx…"
sed -i '/<Helmet>/a \
        <meta property="og:type" content="website" />\
        <meta property="og:title" content="LuxeEvents — L’Exception sur mesure" />\
        <meta property="og:description" content="Vivez l’Exception avec nos expériences exclusives : cocktails, jazz, banquets royaux…" />\
        <meta property="og:image" content="/icons/icon-512.png" />\
        <meta name="twitter:card" content="summary_large_image" />\
        <meta name="twitter:title" content="LuxeEvents — L’Exception sur mesure" />\
        <meta name="twitter:description" content="Vivez l’Exception avec nos expériences exclusives." />\
        <meta name="twitter:image" content="/icons/icon-512.png" />' src/components/Layout.jsx

# 3) Sentry monitoring
echo "3) Installation @sentry/react & @sentry/tracing…"
npm install @sentry/react @sentry/tracing --save
echo "   → Initialisation Sentry dans src/main.jsx…"
sed -i '/import react from/a import * as Sentry from "@sentry\/react"\nimport { BrowserTracing } from "@sentry\/tracing"' src/main.jsx
sed -i '/createRoot/a \
Sentry.init({\
  dsn: "https://<TON_DSN>@o0.ingest.sentry.io/0",\
  integrations: [new BrowserTracing()],\
  tracesSampleRate: 1.0,\
});' src/main.jsx

# 4) Error Boundary
echo "4) Création de src/components/ErrorBoundary.jsx…"
tee src/components/ErrorBoundary.jsx > /dev/null << 'EOF'
import React from 'react'
import * as Sentry from '@sentry/react'

export class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props)
    this.state = { hasError: false }
  }
  static getDerivedStateFromError() {
    return { hasError: true }
  }
  componentDidCatch(error, errorInfo) {
    Sentry.captureException(error, { extra: errorInfo })
  }
  render() {
    if (this.state.hasError) {
      return (
        <div className="p-8 text-center">
          <h1>Oups, une erreur est survenue.</h1>
          <button onClick={() => window.location.reload()} className="mt-4 bg-luxeGold px-4 py-2 rounded">
            Recharger
          </button>
        </div>
      )
    }
    return this.props.children
  }
}
EOF

echo "   → Enrobage de <App/> avec <ErrorBoundary> dans src/main.jsx…"
sed -i '/<HelmetProvider>/a \  <ErrorBoundary>' src/main.jsx
sed -i '/<\/Router>/a \  </ErrorBoundary>' src/main.jsx
sed -i '/import { HelmetProvider/a import { ErrorBoundary } from ".\/components\/ErrorBoundary"' src/main.jsx

echo "✅ Setup Next-Gen terminé ! Relance vite : npm run dev -- --host"
