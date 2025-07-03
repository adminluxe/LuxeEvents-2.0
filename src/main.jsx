import React from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import "./i18n"
import Router from './routes'
import './index.css'

ReactDOM.createRoot(document.getElementById('root')).render(
Sentry.init({
  dsn: "https://<TON_DSN>@o0.ingest.sentry.io/0",
  integrations: [new BrowserTracing()],
  tracesSampleRate: 1.0,
});
  <BrowserRouter>
    <Router />
  </BrowserRouter>
)
