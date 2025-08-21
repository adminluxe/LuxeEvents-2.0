import { useEffect } from "react";

export default function CTAGoldEnhancer() {
  useEffect(() => {
    const add = (el) => {
      if (!el) return;
      const cls = ["btn-gold","ripple","halo","ux-glass"];
      const cur = (el.getAttribute("class") || el.getAttribute("className") || "");
      const toAdd = cls.filter(c => !cur.split(/\s+/).includes(c));
      if (toAdd.length) el.setAttribute("class", (cur + " " + toAdd.join(" ")).trim());
      // ripple coords
      el.addEventListener("click", (e) => {
        const r = el.getBoundingClientRect();
        el.style.setProperty("--x", (e.clientX - r.left) + "px");
        el.style.setProperty("--y", (e.clientY - r.top) + "px");
        el.classList.add("ripple");
        setTimeout(() => el.classList.remove("ripple"), 600);
      }, { passive: true });
    };

    const selectors = [
      'a[href*="/devis"]',
      'a.cta','a.btn','a.button','a[role="button"]',
      'button[type="submit"]','button.cta','button.btn','button.button',
      '[data-cta]','[data-cta-primary]'
    ];
    const nodes = document.querySelectorAll(selectors.join(","));
    nodes.forEach(add);

    // Mutation observer pour les hydrations tardives
    const mo = new MutationObserver((muts) => {
      muts.forEach(m => m.addedNodes && m.addedNodes.forEach(n => {
        if (!(n instanceof HTMLElement)) return;
        if (selectors.some(sel => n.matches && n.matches(sel))) add(n);
        n.querySelectorAll && n.querySelectorAll(selectors.join(",")).forEach(add);
      }));
    });
    mo.observe(document.documentElement, { childList: true, subtree: true });
    return () => mo.disconnect();
  }, []);
  return null;
}
