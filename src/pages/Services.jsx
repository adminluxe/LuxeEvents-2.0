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
