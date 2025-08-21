import React, { useEffect } from "react";
import { createPortal } from "react-dom";

export default function Lightbox({ open, src, alt = "", onClose }) {
  useEffect(() => {
    if (!open) return;
    const onKey = (e) => e.key === "Escape" && onClose?.();
    document.addEventListener("keydown", onKey);
    document.documentElement.style.overflow = "hidden";
    return () => {
      document.removeEventListener("keydown", onKey);
      document.documentElement.style.overflow = "";
    };
  }, [open, onClose]);

  if (!open) return null;

  return createPortal(
    <div
      className="fixed inset-0 z-[9999] bg-black/80 backdrop-blur-sm flex items-center justify-center p-4"
      role="dialog"
      aria-modal="true"
      onClick={onClose}
    >
      <figure className="max-w-5xl w-full" onClick={(e) => e.stopPropagation()}>
        <img src={src} alt={alt} className="w-full h-auto rounded-xl shadow-2xl" />
        <figcaption className="sr-only">{alt}</figcaption>
      </figure>
      <button
        onClick={onClose}
        className="absolute top-4 right-4 rounded-full bg-white/10 hover:bg-white/20 text-white px-3 py-1"
        aria-label="Fermer l’aperçu"
      >
        ✕
      </button>
    </div>,
    document.body
  );
}
