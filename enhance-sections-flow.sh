#!/bin/bash
echo "✨ Intégration des sections About, Events, Contact dans le flux immersif..."

# 1. Création des composants s'ils n'existent pas déjà
mkdir -p src/components

# AboutSection
cat > src/components/AboutSection.jsx << 'EOF'
import { motion } from "framer-motion";

export default function AboutSection() {
  return (
    <section className="min-h-screen py-20 px-4 bg-white dark:bg-zinc-800 scroll-snap-start">
      <div className="max-w-4xl mx-auto text-center">
        <motion.h2
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
          className="text-3xl font-bold text-zinc-900 dark:text-yellow-100 mb-4"
        >
          À propos
        </motion.h2>
        <p className="text-zinc-700 dark:text-zinc-300 text-lg">
          LuxeEvents est né d’un rêve : rendre le luxe événementiel accessible, élégant et magique.
        </p>
      </div>
    </section>
  );
}
EOF

# EventsSection
cat > src/components/EventsSection.jsx << 'EOF'
import { motion } from "framer-motion";

export default function EventsSection() {
  return (
    <section className="min-h-screen py-20 px-4 bg-yellow-50 dark:bg-zinc-900 scroll-snap-start">
      <div className="max-w-4xl mx-auto text-center">
        <motion.h2
          initial={{ opacity: 0, scale: 0.8 }}
          whileInView={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.6 }}
          className="text-3xl font-bold text-zinc-800 dark:text-yellow-100 mb-4"
        >
          Événements
        </motion.h2>
        <p className="text-zinc-700 dark:text-zinc-300 text-lg">
          Mariages, soirées privées, lancements de produits… chaque événement devient un moment inoubliable.
        </p>
      </div>
    </section>
  );
}
EOF

# ContactSection
cat > src/components/ContactSection.jsx << 'EOF'
import { motion } from "framer-motion";

export default function ContactSection() {
  return (
    <section className="min-h-screen py-20 px-4 bg-zinc-100 dark:bg-zinc-950 scroll-snap-start">
      <div className="max-w-4xl mx-auto text-center">
        <motion.h2
          initial={{ opacity: 0, x: -30 }}
          whileInView={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.6 }}
          className="text-3xl font-bold text-zinc-900 dark:text-yellow-100 mb-4"
        >
          Contact
        </motion.h2>
        <p className="text-zinc-700 dark:text-zinc-300 text-lg">
          Une idée, un projet, une envie ? Parlons-en et créons ensemble l’événement parfait.
        </p>
      </div>
    </section>
  );
}
EOF

# 2. Import et insertion dans HomePage.jsx
sed -i '/<\/HeroSection>/a import AboutSection from "@/components/AboutSection";import EventsSection from "@/components/EventsSection";import ContactSection from "@/components/ContactSection";' src/pages/HomePage.jsx

sed -i '/<\/HeroSection>/a       <AboutSection />      <EventsSection />      <ContactSection />' src/pages/HomePage.jsx

# 3. Commit automatique
git add src/components/*Section.jsx src/pages/HomePage.jsx
git commit -m "📚 Intégration des sections About, Events, Contact avec effet scroll-snap immersif"

echo "✅ Sections intégrées et prêtes à swiper dans le flux immersif."
