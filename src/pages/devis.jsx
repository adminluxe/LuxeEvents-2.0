import React from "react";
import DevisLanding from "../components/DevisLanding.jsx";

export default function DevisPage() {
  return (
    <main className="devis-scope min-h-screen bg-black text-white">
      <div className="relative">
        <div
          className="absolute inset-0 -z-10 opacity-60"
          style={{
            background:
              "radial-gradient(1200px 600px at 20% 10%, rgba(212,175,55,0.22), transparent 60%), radial-gradient(900px 500px at 80% 20%, rgba(212,175,55,0.12), transparent 55%), radial-gradient(800px 600px at 50% 90%, rgba(255,255,255,0.06), transparent 60%)",
          }}
        />
        <div className="mx-auto w-full max-w-5xl px-4 sm:px-6 lg:px-8 pt-20 sm:pt-24 pb-16">
          <div className="mb-8">
            <p className="text-xs tracking-[0.25em] uppercase text-yellow-300/80">
              LuxeEvents
            </p>
            <h1 className="mt-2 text-3xl sm:text-4xl font-semibold">
              Demande de devis
            </h1>
            <p className="mt-2 text-white/70 max-w-2xl">
              Quelques infos rapides, et on te propose une expérience sur-mesure.
            </p>
          </div>

          <div className="rounded-3xl border border-white/10 bg-black/40 backdrop-blur-xl shadow-2xl shadow-yellow-400/5 p-5 sm:p-7">
            <DevisLanding />
          </div>
        </div>
      </div>
    </main>
  );
}
