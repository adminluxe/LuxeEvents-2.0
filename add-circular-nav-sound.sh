#!/bin/bash
echo "🌐 Ajout du menu circulaire contextuel + sons immersifs par section..."

# 1. Création des sons (placeholders dans public/sounds)
mkdir -p public/sounds
touch public/sounds/about.mp3
touch public/sounds/events.mp3
touch public/sounds/contact.mp3

# 2. Création de CircularNav.jsx
cat > src/components/CircularNav.jsx << 'EOF'
import { useState, useEffect } from "react";

const sections = [
  { id: "hero", label: "Accueil", sound: null },
  { id: "about", label: "À propos", sound: "/sounds/about.mp3" },
  { id: "events", label: "Événements", sound: "/sounds/events.mp3" },
  { id: "contact", label: "Contact", sound: "/sounds/contact.mp3" },
];

export default function CircularNav() {
  const [active, setActive] = useState("hero");
  const [audio] = useState(new Audio());

  useEffect(() => {
    const handleScroll = () => {
      for (let i = 0; i < sections.length; i++) {
        const el = document.getElementById(sections[i].id);
        if (el && el.getBoundingClientRect().top < window.innerHeight / 2) {
          if (active !== sections[i].id) {
            setActive(sections[i].id);
            if (sections[i].sound) {
              audio.src = sections[i].sound;
              audio.volume = 0.3;
              audio.play().catch(() => {});
            }
          }
        }
      }
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, [active, audio]);

  const scrollTo = (id) => {
    const el = document.getElementById(id);
    if (el) el.scrollIntoView({ behavior: "smooth" });
  };

  return (
    <div className="fixed bottom-8 right-8 z-50 flex flex-col items-center gap-3">
      {sections.map((s, i) => (
        <button
          key={s.id}
          onClick={() => scrollTo(s.id)}
          className={\`w-12 h-12 rounded-full flex items-center justify-center text-sm font-semibold 
            \${active === s.id ? 'bg-yellow-400 text-white scale-110' : 'bg-white dark:bg-zinc-700 text-zinc-800 dark:text-yellow-100'} 
            shadow-lg hover:scale-105 transition-transform\`}
        >
          {s.label[0]}
        </button>
      ))}
    </div>
  );
}
EOF

# 3. Ajout des IDs sur les sections
sed -i 's/<HeroSection \/>/<section id="hero"><HeroSection \/><\/section>/g' src/pages/HomePage.jsx
sed -i 's/<AboutSection \/>/<section id="about"><AboutSection \/><\/section>/g' src/pages/HomePage.jsx
sed -i 's/<EventsSection \/>/<section id="events"><EventsSection \/><\/section>/g' src/pages/HomePage.jsx
sed -i 's/<ContactSection \/>/<section id="contact"><ContactSection \/><\/section>/g' src/pages/HomePage.jsx

# 4. Intégration de CircularNav dans HomePage.jsx
sed -i '/<\/ContactSection>/a       <CircularNav />' src/pages/HomePage.jsx
sed -i '/import .*ContactSection/a import CircularNav from "@/components/CircularNav";' src/pages/HomePage.jsx

# 5. Commit
git add src/components/CircularNav.jsx src/pages/HomePage.jsx public/sounds/*
git commit -m "🧭 Menu circulaire contextuel + effets sonores immersifs par section"

echo "✅ Menu circulaire luxe & sons immersifs par section intégrés avec succès."
