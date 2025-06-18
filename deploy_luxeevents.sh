#!/bin/bash

PAGES_DIR="./src/pages"
mkdir -p "$PAGES_DIR"

echo "🚀 Déploiement des composants React LuxeEvents..."

write_file() {
  local filename=$1
  cat > "$PAGES_DIR/$filename"
}

# Home.jsx
write_file "Home.jsx" <<'EOF'
import React from "react";

export default function Home() {
  return (
    <main style={{ fontFamily: "'Segoe UI', Tahoma, Geneva, Verdana, sans-serif", maxWidth: "900px", margin: "3rem auto", padding: "0 1rem", color: "#222" }}>
      <section style={{ textAlign: "center", marginBottom: "3rem" }}>
        <h1 style={{ fontWeight: "900", fontSize: "3rem", color: "#4a148c", letterSpacing: "0.1em" }}>
          Le luxe n’est plus une question de moyens, mais d’expérience.
        </h1>
        <p style={{ fontSize: "1.3rem", marginTop: "1rem", fontWeight: "600", color: "#6a1b9a" }}>
          Chez LuxeEvents, nous orchestrons des moments uniques, élégants, et accessibles.<br />
          Laissez-nous sublimer votre prochain événement avec une touche d’excellence sur-mesure.
        </p>
        <button style={{ marginTop: "2rem", padding: "1rem 2rem", backgroundColor: "#4a148c", color: "#fff", border: "none", borderRadius: "6px", fontWeight: "700", cursor: "pointer" }}>
          Demandez un devis
        </button>
      </section>

      <section style={{ display: "flex", justifyContent: "space-around", marginBottom: "3rem" }}>
        {[
          { icon: "🎉", title: "Organisation complète", desc: "De la conception à la réalisation, on gère tout." },
          { icon: "🤝", title: "Coordination Jour J", desc: "Pour que vous profitiez sans souci." },
          { icon: "✨", title: "Détails personnalisés", desc: "Chaque événement est unique, comme vous." },
          { icon: "💎", title: "Luxe accessible", desc: "Élégance et raffinement à prix juste." }
        ].map((service, i) => (
          <div key={i} style={{ maxWidth: "200px", textAlign: "center" }}>
            <div style={{ fontSize: "3rem" }}>{service.icon}</div>
            <h3 style={{ color: "#6a1b9a", marginBottom: "0.5rem" }}>{service.title}</h3>
            <p style={{ color: "#555" }}>{service.desc}</p>
          </div>
        ))}
      </section>

      <section style={{ textAlign: "center", borderTop: "1px solid #ddd", paddingTop: "2rem" }}>
        <h2 style={{ color: "#4a148c", marginBottom: "1rem" }}>Ils nous font confiance</h2>
        <blockquote style={{ fontStyle: "italic", color: "#444", maxWidth: "700px", margin: "auto" }}>
          « LuxeEvents a transformé notre mariage en un conte de fées moderne. Professionnalisme et créativité à l’état pur ! » <br />
          <strong>- Julie & Marc</strong>
        </blockquote>
      </section>
    </main>
  );
}
EOF

# About.jsx
write_file "About.jsx" <<'EOF'
import React from "react";

export default function About() {
  return (
    <main style={{ maxWidth: "800px", margin: "3rem auto", fontFamily: "'Segoe UI', Tahoma, Geneva, Verdana, sans-serif", padding: "0 1rem", color: "#222" }}>
      <h1 style={{ color: "#4a148c", marginBottom: "2rem" }}>Notre histoire</h1>
      <p style={{ fontSize: "1.2rem", lineHeight: "1.6" }}>
        LuxeEvents est né de la passion pour l’excellence et le désir de rendre le luxe accessible à tous. Nous croyons que chaque événement mérite d’être unique, à la hauteur de vos rêves les plus fous.
      </p>
      <p style={{ fontSize: "1.2rem", lineHeight: "1.6" }}>
        Notre équipe d’experts dédie son énergie à transformer vos idées en expériences inoubliables, avec une attention minutieuse aux détails et un engagement sans faille.
      </p>
      <h2 style={{ color: "#6a1b9a", marginTop: "3rem" }}>Notre philosophie</h2>
      <p style={{ fontSize: "1.1rem", fontStyle: "italic", color: "#555" }}>
        « Le luxe, c’est avant tout une expérience humaine, un souffle d’émotion et un soin tout particulier porté à chaque instant. »  
      </p>
    </main>
  );
}
EOF

# Services.jsx
write_file "Services.jsx" <<'EOF'
import React from "react";

const services = [
  { title: "Organisation complète", desc: "Du brainstorming à la soirée, on s’occupe de tout pour que vous profitiez sans stress." },
  { title: "Coordination Jour J", desc: "Une équipe dédiée pour que chaque moment se déroule à la perfection." },
  { title: "Location de matériel", desc: "Mobilier, sonorisation, éclairage : tout le nécessaire livré et installé." },
  { title: "Conseil & conception", desc: "Un accompagnement sur-mesure pour créer un événement à votre image." },
];

export default function Services() {
  return (
    <main style={{ maxWidth: "900px", margin: "3rem auto", padding: "0 1rem", fontFamily: "'Segoe UI', Tahoma, Geneva, Verdana, sans-serif", color: "#222" }}>
      <h1 style={{ color: "#4a148c", marginBottom: "2rem" }}>Nos services</h1>
      {services.map((s, i) => (
        <section key={i} style={{ marginBottom: "2rem", borderLeft: "5px solid #6a1b9a", paddingLeft: "1rem" }}>
          <h2 style={{ marginBottom: "0.5rem" }}>{s.title}</h2>
          <p style={{ fontSize: "1.1rem", color: "#555" }}>{s.desc}</p>
        </section>
      ))}
      <p style={{ textAlign: "center", marginTop: "3rem", fontWeight: "700" }}>
        Pour un devis personnalisé, contactez-nous sans attendre.
      </p>
    </main>
  );
}
EOF

# Contact.jsx
write_file "Contact.jsx" <<'EOF'
import React, { useState } from "react";

export default function Contact() {
  const [form, setForm] = useState({ name: "", email: "", message: "" });
  const [submitted, setSubmitted] = useState(false);

  const handleChange = e => setForm({ ...form, [e.target.name]: e.target.value });
  const handleSubmit = e => {
    e.preventDefault();
    // Ici, envoi du formulaire (via API ou email)
    setSubmitted(true);
  };

  return (
    <main style={{ maxWidth: "600px", margin: "3rem auto", fontFamily: "'Segoe UI', Tahoma, Geneva, Verdana, sans-serif", padding: "0 1rem", color: "#222" }}>
      <h1 style={{ color: "#4a148c", marginBottom: "2rem" }}>Contactez-nous</h1>
      {!submitted ? (
        <form onSubmit={handleSubmit} style={{ display: "flex", flexDirection: "column", gap: "1rem" }}>
          <input
            name="name"
            placeholder="Votre nom"
            value={form.name}
            onChange={handleChange}
            required
            style={{ padding: "0.8rem", borderRadius: "6px", border: "1px solid #ccc", fontSize: "1rem" }}
          />
          <input
            name="email"
            type="email"
            placeholder="Votre email"
            value={form.email}
            onChange={handleChange}
            required
            style={{ padding: "0.8rem", borderRadius: "6px", border: "1px solid #ccc", fontSize: "1rem" }}
          />
          <textarea
            name="message"
            placeholder="Votre message"
            value={form.message}
            onChange={handleChange}
            required
            rows="5"
            style={{ padding: "0.8rem", borderRadius: "6px", border: "1px solid #ccc", fontSize: "1rem" }}
          />
          <button type="submit" style={{ padding: "1rem", backgroundColor: "#4a148c", color: "#fff", border: "none", borderRadius: "6px", fontWeight: "700", cursor: "pointer" }}>
            Envoyer
          </button>
        </form>
      ) : (
        <p style={{ color: "#4a148c", fontWeight: "700" }}>
          Merci pour votre message ! Nous reviendrons vers vous très vite.
        </p>
      )}
    </main>
  );
}
EOF

echo "✅ Tous les composants ont été écrasés avec succès dans $PAGES_DIR !"
echo "N’oublie pas de relancer ton serveur de dev si besoin : npm start ou yarn start."

