import React from "react";
export default function Footer(){
  return (
    <footer className="mt-20 border-t border-zinc-200 dark:border-zinc-800 py-8 text-sm">
      <div className="max-w-6xl mx-auto px-4 flex flex-col md:flex-row gap-4 md:items-center md:justify-between">
        <p>© {new Date().getFullYear()} LuxeEvents — Luxe • Excellence • Innovation</p>
        <nav className="flex gap-4">
          <a href="/mentions-legales">Mentions légales</a>
          <a href="/politique-confidentialite">Politique de confidentialité</a>
          <a href="https://instagram.com" target="_blank" rel="noreferrer">Instagram</a>
          <a href="https://www.linkedin.com" target="_blank" rel="noreferrer">LinkedIn</a>
        </nav>
      </div>
    </footer>
  );
}
