"use client";

import { useState } from "react";

export default function QuoteForm() {
  const [form, setForm] = useState({ name: "", email: "", message: "" });
  const [status, setStatus] = useState("idle");

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setStatus("loading");
    try {
      const res = await fetch("/api/contact", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(form),
      });
      if (!res.ok) throw new Error("Erreur lors de l’envoi");
      setStatus("success");
      setForm({ name: "", email: "", message: "" });
    } catch (err) {
      setStatus("error");
    }
  };

  return (
    <section className="py-24 px-4 bg-white text-black dark:bg-black dark:text-white">
      <div className="max-w-3xl mx-auto">
        <h2 className="text-3xl md:text-5xl font-bold text-gold mb-12 text-center">
          Demande de devis
        </h2>
        <form onSubmit={handleSubmit} className="space-y-6">
          <input
            type="text"
            name="name"
            value={form.name}
            onChange={handleChange}
            placeholder="Nom complet"
            className="w-full p-3 rounded bg-white/10 border border-gold text-white"
            required
          />
          <input
            type="email"
            name="email"
            value={form.email}
            onChange={handleChange}
            placeholder="Adresse email"
            className="w-full p-3 rounded bg-white/10 border border-gold text-white"
            required
          />
          <textarea
            name="message"
            value={form.message}
            onChange={handleChange}
            placeholder="Votre message"
            rows={5}
            className="w-full p-3 rounded bg-white/10 border border-gold text-white"
            required
          />
          <button
            className='btn-gold halo ux-glass' type="submit"
            className="px-6 py-3 bg-gold text-black rounded hover:bg-yellow-300 transition font-semibold"
          >
            {status === "loading" ? "Envoi..." : "Envoyer"}
          </button>
          {status === "success" && (
            <p className="text-green-500">✅ Message envoyé !</p>
          )}
          {status === "error" && (
            <p className="text-red-500">❌ Une erreur est survenue.</p>
          )}
        </form>
      </div>
    </section>
  );
}
