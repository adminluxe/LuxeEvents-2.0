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
