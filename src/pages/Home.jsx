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
