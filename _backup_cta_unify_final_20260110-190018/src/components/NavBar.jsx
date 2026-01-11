import { useEffect, useState } from "react";

const LinkItem = ({ href, children, current }) => {
  const active = current === href || (href.includes("#") && current === "/");
  return (
    <a
      href={href}
      className={"relative px-3 py-2 transition-colors " +
        (active ? "text-yellow-400" : "text-white/90 hover:text-white")}
    >
      <span className="relative sticky top-0 z-50 backdrop-blur supports-[backdrop-filter]:bg-black/30 bg-black/20 ">
        {children}
        <span className="block absolute left-0 -bottom-1 h-[2px] w-0 group-hover:w-full transition-[width] sticky top-0 z-50 backdrop-blur supports-[backdrop-filter]:bg-black/30 bg-black/20 
                         bg-gradient-to-r from-yellow-300 via-yellow-400 to-yellow-500"></span>
      </span>
    </a>
  );
};

export default function NavBar() {
  const [path, setPath] = useState("/");
  useEffect(() => {
    if (typeof window !== "undefined") setPath(window.location.pathname || "/");
  }, []);
  return (
    <nav className="flex gap-1 md:gap-2 items-center group gap-6 sticky top-0 z-50 backdrop-blur supports-[backdrop-filter]:bg-black/30 bg-black/20 ">
  <div className="flex items-center gap-2 sticky top-0 z-50 backdrop-blur supports-[backdrop-filter]:bg-black/30 bg-black/20 "><img src="/logo_gold_black.png" alt="LuxeEvents" className="h-7 w-auto" /><span className="sr-only">LuxeEvents</span></div>
      <LinkItem href="/" current={path}>Accueil</LinkItem>
      <LinkItem href="/#services" current={path}>Services</LinkItem>
      <LinkItem href="/devis" current={path}>Devis</LinkItem>
      <LinkItem href="/mentions-legales" current={path}>Mentions</LinkItem>
      <a href="/faq" className="px-3 py-2 hover:underline">FAQ</a>
      <a href="/realisations" className="px-3 py-2 hover:underline">Réalisations</a>
  <a href="/#temoignages" className="px-3 py-2 hover:underline">Témoignages</a>
</nav>
  );
}
