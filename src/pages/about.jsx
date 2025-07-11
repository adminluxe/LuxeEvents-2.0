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
