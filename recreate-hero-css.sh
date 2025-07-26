#!/bin/bash

echo "🧹 Suppression ancienne version potentiellement corrompue..."
rm -f src/components/HeroSection.css

echo "🎨 Recréation propre de HeroSection.css..."
cat <<'CSS' > src/components/HeroSection.css
/* HeroSection.css - clean reset */

.hero-container {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  padding: 2rem;
  background-color: #0e0c0c;
  color: #f8e9c8;
  flex-direction: column;
  text-align: center;
}

.hero-title {
  font-size: 3rem;
  font-weight: bold;
  color: #f8e9c8;
  text-shadow: 2px 2px 4px #000;
}

.hero-subtitle {
  font-size: 1.5rem;
  margin-top: 1rem;
  color: #fff8dc;
  text-shadow: 1px 1px 3px #000;
}

.hero-button {
  margin-top: 2rem;
  padding: 1rem 2rem;
  background-color: transparent;
  border: 2px solid #f8e9c8;
  color: #f8e9c8;
  border-radius: 9999px;
  font-weight: 600;
  transition: all 0.3s ease-in-out;
  text-shadow: 1px 1px 2px #000;
  cursor: pointer;
}

.hero-button:hover {
  background-color: #f8e9c8;
  color: #0e0c0c;
  box-shadow: 0 0 12px #f8e9c8;
}
CSS

echo "✅ HeroSection.css recréé avec succès !"
