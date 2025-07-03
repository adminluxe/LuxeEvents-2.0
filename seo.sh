#!/usr/bin/env bash
set -euo pipefail

echo "🖋️  Démarrage du setup SEO & Contenu…"

# 1) Création des pages React
echo "1) Création des pages About, Team et Blog…"
mkdir -p src/pages
tee src/pages/About.jsx > /dev/null << 'EOF'
import React from 'react';
import { Helmet } from 'react-helmet';
export default function About() {
  return (
    <>
      <Helmet>
        <title>À propos | LuxeEvents</title>
        <meta name="description" content="Découvrez la vision, la mission et l’histoire de LuxeEvents, votre partenaire pour des événements inoubliables." />
      </Helmet>
      <main className="prose mx-auto p-8">
        <h1>À propos de LuxeEvents</h1>
        <p>Chez LuxeEvents, nous transformons vos rêves en expériences hors du commun…</p>
      </main>
    </>
  );
}
EOF

tee src/pages/Team.jsx > /dev/null << 'EOF'
import React from 'react';
import { Helmet } from 'react-helmet';
export default function Team() {
  return (
    <>
      <Helmet>
        <title>Équipe | LuxeEvents</title>
        <meta name="description" content="Rencontrez les artisans de vos événements : l’équipe passionnée de LuxeEvents." />
      </Helmet>
      <main className="prose mx-auto p-8">
        <h1>Notre Équipe</h1>
        <ul>
          <li>🎩 Alice, Directrice Artistique</li>
          <li>📊 Bob, Expert Analytics</li>
          <li>🌐 Chloé, Responsable International</li>
        </ul>
      </main>
    </>
  );
}
EOF

tee src/pages/Blog.jsx > /dev/null << 'EOF'
import React from 'react';
import { Helmet } from 'react-helmet';
import fs from 'fs';
import path from 'path';
import matter from 'gray-matter';
import Link from 'next/link'; // ou react-router
export default function Blog() {
  const postsDir = path.join(process.cwd(), 'content/blog');
  const files = fs.readdirSync(postsDir).filter(f => f.endsWith('.md'));
  const posts = files.map(filename => {
    const { data } = matter(fs.readFileSync(path.join(postsDir, filename)));
    return { slug: filename.replace('.md',''), title: data.title, date: data.date };
  });
  return (
    <>
      <Helmet>
        <title>Blog | LuxeEvents</title>
        <meta name="description" content="Les dernières tendances événementielles, études de cas et conseils pro par LuxeEvents." />
      </Helmet>
      <main className="prose mx-auto p-8">
        <h1>Blog</h1>
        <ul>
          {posts.map(p => (
            <li key={p.slug}>
              <Link to={`/blog/${p.slug}`}>{p.title}</Link> — <em>{p.date}</em>
            </li>
          ))}
        </ul>
      </main>
    </>
  );
}
EOF

# 2) Création du dossier content pour les posts
echo "2) Bootstrap du dossier de blog…"
mkdir -p content/blog
tee content/blog/2025-07-01-introducing-luxeevents.md > /dev/null << 'EOF'
---
title: "Bienvenue sur le blog de LuxeEvents"
date: "2025-07-01"
---

Bienvenue ! Ici, chaque mois, on décortique :
- Les **tendances** événementielles
- Des **retours d’expérience** clients
- Des **études de cas** exclusives

Restez connectés, la magie commence ! ✨
EOF

# 3) Meta + Open Graph global dans Layout.jsx
echo "3) Injection des meta OG et JSON-LD globaux…"
sed -i "/<Helmet>/a \
  <meta property=\"og:site_name\" content=\"LuxeEvents\"/>\
  <meta property=\"og:type\" content=\"website\"/>\
  <meta property=\"og:image\" content=\"/images/og-default.jpg\"/>\
  <script type=\"application/ld+json\">\
  {\
    \"@context\": \"https://schema.org\",\
    \"@type\": \"Organization\",\
    \"url\": \"https://www.luxeevents.com\",\
    \"logo\": \"https://www.luxeevents.com/logo.png\"\
  }\
  </script>" src/components/Layout.jsx

# 4) Génération du sitemap.xml
echo "4) Création de sitemap.xml…"
tee public/sitemap.xml > /dev/null << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="https://www.sitemaps.org/schemas/sitemap/0.9">
  <url><loc>https://www.luxeevents.com/</loc><priority>1.0</priority></url>
  <url><loc>https://www.luxeevents.com/about</loc><priority>0.8</priority></url>
  <url><loc>https://www.luxeevents.com/team</loc><priority>0.8</priority></url>
  <url><loc>https://www.luxeevents.com/blog</loc><priority>0.7</priority></url>
</urlset>
EOF

# 5) Robots.txt
echo "5) Création de robots.txt…"
tee public/robots.txt > /dev/null << 'EOF'
User-agent: *
Allow: /
Sitemap: https://www.luxeevents.com/sitemap.xml
EOF

echo "✅ SEO & Contenu bootstrappés !  
→ Relance ton dev : npm run dev -- --host  
→ Personnalise les textes et enrichis ton blog petit à petit. 🚀"
