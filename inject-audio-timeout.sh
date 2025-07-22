#!/bin/bash

echo "🛠 Injection du fallback audio + trigger loader..."

# Ajout du useEffect de fallback dans AudioAmbient.jsx
TARGET="src/components/AudioAmbient.jsx"

if grep -q "useEffect(() => {" "$TARGET"; then
  echo "⚠️ useEffect déjà détecté dans AudioAmbient.jsx, injection manuelle recommandée si conflit."
else
cat << 'JSX' >> "$TARGET"

useEffect(() => {
  const timeout = setTimeout(() => {
    console.log("✅ Timeout déclenché : on force la suite !");
    const evt = new Event("audio-ready");
    window.dispatchEvent(evt);
  }, 5000); // sécurité : on débloque après 5s

  return () => clearTimeout(timeout);
}, []);
JSX

  echo "✅ Fallback timeout injecté dans $TARGET"
fi

# Ajout de l’écoute de 'audio-ready' dans App.jsx
APP="src/App.jsx"

if grep -q "audio-ready" "$APP"; then
  echo "⚠️ Handler 'audio-ready' déjà présent dans App.jsx"
else
cat << 'JSX' >> "$APP"

useEffect(() => {
  const handler = () => {
    console.log("🎬 audio-ready reçu, on affiche la suite");
    // 🔁 À adapter selon ta logique : showHome, setIsReady, etc.
    // Exemple :
    // setShowMainApp(true);
  };

  window.addEventListener("audio-ready", handler);
  return () => window.removeEventListener("audio-ready", handler);
}, []);
JSX

  echo "✅ Listener 'audio-ready' injecté dans $APP"
fi

echo "♻️ Prêt pour redeploiement !"
