#!/bin/bash

echo "🛠️ Injection useEffect 'audio-ready' dans App.jsx..."

sed -i '/function App()/a \
  useEffect(() => {\
    const handler = () => {\
      console.log("🎬 audio-ready reçu, on force la suite");\
      sessionStorage.setItem("introPlayed", "true");\
      setIntroFinished(true);\
    };\
    window.addEventListener("audio-ready", handler);\
    return () => window.removeEventListener("audio-ready", handler);\
  }, []);' src/App.jsx

echo "✅ Patch App.jsx injecté avec gestion de l'événement audio-ready"
