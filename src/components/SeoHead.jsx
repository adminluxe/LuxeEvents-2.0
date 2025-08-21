import { useEffect } from "react";

function upsertMeta(selector, attrs) {
  let el = document.head.querySelector(selector);
  if (!el) { el = document.createElement('meta'); document.head.appendChild(el); }
  Object.entries(attrs).forEach(([k, v]) => el.setAttribute(k, v));
  return el;
}

function upsertLink(rel, href) {
  let el = document.head.querySelector(`link[rel="${rel}"]`);
  if (!el) { el = document.createElement('link'); el.setAttribute('rel', rel); document.head.appendChild(el); }
  el.setAttribute('href', href);
  return el;
}

export default function SeoHead({ title, description, canonical, image = "/og-default.jpg" }) {
  useEffect(() => {
    if (title) document.title = title;
    if (description) upsertMeta('meta[name="description"]', { name: 'description', content: description });
    if (canonical) upsertLink('canonical', canonical);

    // Open Graph
    upsertMeta('meta[property="og:type"]', { property: 'og:type', content: 'website' });
    if (title) upsertMeta('meta[property="og:title"]', { property: 'og:title', content: title });
    if (description) upsertMeta('meta[property="og:description"]', { property: 'og:description', content: description });
    if (canonical) upsertMeta('meta[property="og:url"]', { property: 'og:url', content: canonical });
    if (image) upsertMeta('meta[property="og:image"]', { property: 'og:image', content: image });

    // Twitter
    upsertMeta('meta[name="twitter:card"]', { name: 'twitter:card', content: 'summary_large_image' });
    if (title) upsertMeta('meta[name="twitter:title"]', { name: 'twitter:title', content: title });
    if (description) upsertMeta('meta[name="twitter:description"]', { name: 'twitter:description', content: description });
    if (image) upsertMeta('meta[name="twitter:image"]', { name: 'twitter:image', content: image });

    // Preconnect fonts (idempotent)
    upsertLink('preconnect', 'https://fonts.googleapis.com');
    const gstatic = document.head.querySelector('link[href="https://fonts.gstatic.com"]') ||
      (() => { const l = document.createElement('link'); l.setAttribute('href','https://fonts.gstatic.com'); l.setAttribute('rel','preconnect'); l.setAttribute('crossorigin',''); document.head.appendChild(l); return l; })();

  }, [title, description, canonical, image]);

  return null;
}
