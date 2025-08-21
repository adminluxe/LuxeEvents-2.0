import React from "react";
import { Link } from "react-router-dom";

/**
 * HaloButtonBase
 * - Pas d'<a> imbriqués : on choisit a / Link / button selon props
 * - Compatibilité: export default + export nommé
 * - Astuce anti-nesting: prop forceTag="button" pour forcer un tag non-<a>
 */
function HaloButtonBase({ href, to, as = "auto", forceTag, className = "", children, ...rest }) {
  const classes =
    "inline-flex items-center justify-center px-4 py-2 rounded-full " +
    "bg-white/10 hover:bg-white/20 border border-white/20 backdrop-blur " +
    "transition focus:outline-none focus-visible:ring-2 focus-visible:ring-white/40 " +
    className;

  // Si on force un tag (ex: pour éviter <a> dans <a>)
  if (forceTag === "button") {
    return <button type="button" className={classes} {...rest}>{children}</button>;
  }
  if (forceTag === "span") {
    return <span className={classes} role="link" tabIndex={0} {...rest}>{children}</span>;
  }

  if (as === "a" || href) {
    return <a href={href} className={classes} {...rest}>{children}</a>;
  }
  if (as === "link" || to) {
    return <Link to={to} className={classes} {...rest}>{children}</Link>;
  }
  return <button type="button" className={classes} {...rest}>{children}</button>;
}

// double export pour compat totale
export const HaloButton = HaloButtonBase;
export default HaloButtonBase;
