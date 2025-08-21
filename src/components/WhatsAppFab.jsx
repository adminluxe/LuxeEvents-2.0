import React from "react";

export default function WhatsAppFab({
  phone,                       // ex: "+32470123456"
  message = "Bonjour, j’aimerais organiser un événement avec LuxeEvents.",
}) {
  if (!phone) return null;     // pas de bouton tant que le numéro n’est pas fourni
  const digits = String(phone).replace(/\D/g, "");
  const href = `https://wa.me/${digits}?text=${encodeURIComponent(message)}`;

  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      aria-label="Contact WhatsApp"
      className="fixed bottom-4 right-4 z-50 inline-flex items-center gap-2 rounded-full px-4 py-3 bg-[#25D366] text-black font-semibold shadow-lg hover:brightness-95"
    >
      <svg width="20" height="20" viewBox="0 0 32 32" aria-hidden="true">
        <path fill="currentColor" d="M19.11 17.1c-.27-.14-1.56-.77-1.8-.86c-.24-.09-.41-.14-.58.14s-.67.86-.82 1.04s-.3.21-.57.07a8.86 8.86 0 0 1-2.6-1.61a9.74 9.74 0 0 1-1.8-2.23c-.19-.33 0-.5.14-.68s.33-.39.5-.6a2.17 2.17 0 0 0 .33-.55a.61.61 0 0 0 0-.57c0-.14-.58-1.4-.8-1.91s-.42-.45-.58-.46h-.49a.94.94 0 0 0-.68.32a2.86 2.86 0 0 0-.9 2.12a5 5 0 0 0 1.06 2.66a11.46 11.46 0 0 0 4.38 3.86a14.48 14.48 0 0 0 1.44.53a3.46 3.46 0 0 0 1.59.1a2.59 2.59 0 0 0 1.69-1.18a2.1 2.1 0 0 0 .14-1.18c-.05-.08-.2-.13-.47-.27zM16 3a13 13 0 0 0-11 19.9L3.45 29L9 27.6A13 13 0 1 0 16 3zm7.53 20.53A10.41 10.41 0 0 1 9 26.6l-.4.12l-3 .76l.81-2.93l.13-.39A10.41 10.41 0 1 1 23.53 23.5z"/>
      </svg>
      WhatsApp
    </a>
  );
}
