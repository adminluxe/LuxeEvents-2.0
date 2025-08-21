import React from "react";

export default function CookieConsent() {
  const [ok, setOk] = React.useState(true);
  React.useEffect(() => {
    const v = localStorage.getItem("lx_cookie_ok");
    setOk(!!v);
  }, []);
  if (ok) return null;
  return (
    <div className="fixed bottom-4 left-4 right-4 md:left-1/2 md:-translate-x-1/2 z-50">
      <div className="mx-auto max-w-3xl rounded-xl bg-black/80 text-white p-4 ring-1 ring-white/10 backdrop-blur">
        <p className="text-sm">
          Nous utilisons des cookies pour améliorer votre expérience.{" "}
          <a href="/mentions-legales" className="underline">Mentions légales</a>.
        </p>
        <div className="mt-3 flex gap-3">
          <button
            className="px-3 py-2 rounded-lg bg-white text-black"
            onClick={() => { localStorage.setItem("lx_cookie_ok","1"); location.reload(); }}
          >Accepter</button>
          <button
            className="px-3 py-2 rounded-lg bg-white/10 ring-1 ring-white/20"
            onClick={() => { localStorage.setItem("lx_cookie_ok","1"); location.reload(); }}
          >Fermer</button>
        </div>
      </div>
    </div>
  );
}
