#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Application des corrections sur Map.jsx et Home.jsx…"

# ------------------------------
# 1) Remplace src/components/Map.jsx
# ------------------------------
cat > src/components/Map.jsx << 'EOF'
import React, { useEffect, useState, useRef } from 'react'
import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet'
import 'leaflet/dist/leaflet.css'
import iconRetinaUrl from 'leaflet/dist/images/marker-icon-2x.png'
import iconUrl from 'leaflet/dist/images/marker-icon.png'
import iconShadowUrl from 'leaflet/dist/images/marker-shadow.png'
import L from 'leaflet'

// Configure l'icône par défaut
delete L.Icon.Default.prototype._getIconUrl
L.Icon.Default.mergeOptions({
  iconRetinaUrl,
  iconUrl,
  shadowUrl: iconShadowUrl,
})

// Icône personnalisée : simple divIcon statique
function LuxuryIcon() {
  return L.divIcon({ className: 'luxury-marker' })
}

// Timeline pour panner la carte au survol
function Timeline({ events, onHover }) {
  return (
    <div className="timeline flex items-center justify-between mt-4">
      {events.map((evt, idx) => (
        <div
          key={idx}
          className="timeline-point cursor-pointer flex flex-col items-center"
          onMouseEnter={() => onHover(evt)}
        >
          <div className="w-2 h-2 bg-amber-500 rounded-full mb-1" />
          <span className="text-sm text-gray-600">{evt.date}</span>
        </div>
      ))}
    </div>
  )
}

// Composant Map principal
export default function Map({ events = [] }) {
  const [position, setPosition] = useState([48.8566, 2.3522])
  const mapRef = useRef()

  // Centrage sur la géolocalisation de l'utilisateur
  useEffect(() => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(({ coords }) => {
        setPosition([coords.latitude, coords.longitude])
      })
    }
  }, [])

  // Pan vers un événement
  const panTo = (evt) => {
    if (mapRef.current) {
      mapRef.current.setView([evt.lat, evt.lng], 14, { animate: true })
    }
  }

  return (
    <div>
      <div className="h-96 w-full rounded-2xl shadow p-2">
        <MapContainer
          center={position}
          zoom={13}
          className="h-full w-full"
          whenCreated={(mapInstance) => { mapRef.current = mapInstance }}
        >
          <TileLayer
            attribution='&copy; <a href="https://osm.org/copyright">OpenStreetMap</a>'
            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          />
          {events.map((evt, idx) => (
            <Marker
              key={idx}
              position={[evt.lat, evt.lng]}
              icon={LuxuryIcon()}
            >
              <Popup>
                <strong>{evt.title}</strong><br/>
                {evt.description}<br/>
                <em>{evt.date}</em>
              </Popup>
            </Marker>
          ))}
        </MapContainer>
      </div>
      <Timeline events={events} onHover={panTo} />
    </div>
  )
}
EOF

# ------------------------------
# 2) Remplace src/pages/Home.jsx
# ------------------------------
cat > src/pages/Home.jsx << 'EOF'
import React from 'react'
import { useTranslation } from 'react-i18next'
import Layout from '@/components/Layout'
import { eventsData } from '@/data/events'
import Map from '@/components/Map'

export default function Home() {
  const { t } = useTranslation()
  const features = t('home.features', { returnObjects: true })
  const services = t('home.services', { returnObjects: true })

  return (
    <Layout title={t('home.title')}>
      {/* — Features — */}
      <section className="my-16">
        {Array.isArray(features) && features.map((f, i) => (
          <div key={i} className="mb-8">
            <h2 className="text-xl font-semibold">{f.title}</h2>
            <p className="mt-2 text-gray-600">{f.desc}</p>
          </div>
        ))}
      </section>

      {/* — Services — */}
      <section className="my-16">
        <h3 className="text-2xl font-bold mb-4">{t('home.servicesTitle')}</h3>
        <ul className="list-disc list-inside space-y-2">
          {Array.isArray(services) && services.map((s, i) => (
            <li key={i} className="text-gray-700">{s}</li>
          ))}
        </ul>
      </section>

      {/* — Carte interactive — */}
      <section className="my-16">
        <h2 className="text-2xl font-bold mb-4">{t('home.mapTitle')}</h2>
        <Map events={eventsData} />
      </section>
    </Layout>
  )
}
EOF

echo "✅ Fichiers réécrits."
echo
echo "👉 Ensuite :"
echo "   rm -rf node_modules/.vite"
echo "   pnpm run dev -- --host"
