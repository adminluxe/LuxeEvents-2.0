import React, { useEffect, useState } from "react";
const KEY = "le_consent_v1";
export default function CookieBanner() {
  const [open, setOpen] = useState(false);
  useEffect(() => {
    try { const v = localStorage.getItem(KEY); if (!v) setOpen(true); } catch {}
  }, []);
  const save = (val) => { try { localStorage.setItem(KEY, JSON.stringify(val)); } catch {} setOpen(false); };
  if (!open) return null;
  return (
    <div className="fixed inset-x-0 bottom-0 z-50 mx-auto max-w-4xl rounded-t-2xl border border-yellow-500/20 bg-black/80 text-neutral-100 backdrop-blur p-4 md:p-5">
      <div className="flex flex-col md:flex-row md:items-center gap-3">
        <div className="flex-1">
          <p className="font-medium">Cookies & confidentialité</p>
          <p className="text-sm text-neutral-300">On utilise des cookies techniques et de mesure d’audience anonymisée pour améliorer votre expérience.</p>
          <p className="mt-1 text-xs text-neutral-400">
            Voir <a href="/politique-confidentialite" className="text-yellow-400 hover:underline">Politique</a> et <a href="/cookies" className="text-yellow-400 hover:underline">Cookies</a>.
          </p>
        </div>
        <div className="flex gap-2">
          <button onClick={() => save({necessary:true, analytics:false})} className="rounded-lg border px-3 py-2 text-sm">Refuser</button>
          <button onClick={() => save({necessary:true, analytics:true})} className="rounded-lg bg-yellow-400 text-black px-3 py-2 text-sm hover:bg-yellow-300">Accepter</button>
        </div>
      </div>
    </div>
  );
}
