#!/bin/bash

echo "🔧 Patch React Router & AudioAmbient en cours..."

# 1. Patch main.jsx avec BrowserRouter
cat << 'EOM' > src/main.jsx
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import "./index.css";
import { HelmetProvider } from "react-helmet-async";
import { BrowserRouter } from "react-router-dom";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <HelmetProvider>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </HelmetProvider>
  </React.StrictMode>
);
EOM
echo "✅ main.jsx patché avec BrowserRouter."

# 2. Patch AudioAmbient.jsx avec audio muted
cat << 'EOM' > src/components/AudioAmbient.jsx
import React from 'react'

const AudioAmbient = () => {
  return (
    <audio
      autoPlay
      muted
      loop
      playsInline
      preload="auto"
      src="/audio/ambiance-luxe.mp3"
      id="bg-audio"
    />
  )
}

export default AudioAmbient
EOM
echo "✅ AudioAmbient corrigé avec autoplay et muted."

# 3. Créer dossier public/audio et copier le fichier si existant
mkdir -p public/audio
if [ -f src/assets/audio/ambiance-luxe.mp3 ]; then
  cp src/assets/audio/ambiance-luxe.mp3 public/audio/
  echo "🎵 Fichier audio copié vers public/audio/"
else
  echo "⚠️ Le fichier src/assets/audio/ambiance-luxe.mp3 est introuvable."
fi

echo "🚀 Patch terminé. Tu peux maintenant lancer : pnpm run dev"
