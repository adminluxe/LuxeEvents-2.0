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
