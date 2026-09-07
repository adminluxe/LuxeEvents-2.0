import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { pageMeta, structuredData } from "../src/purple/pageMeta.js";

const root = fileURLToPath(new URL("../dist/", import.meta.url));
const base = readFileSync(join(root, "index.html"), "utf8");

const routes = [
  { output: "index.html", meta: pageMeta.homeFr, hero: true, noscript: "Direction créative, coordination et production d’événements privés, professionnels et de marque." },
  { output: "en/index.html", meta: pageMeta.homeEn, hero: true, noscript: "Creative direction, coordination and production for private, professional and brand events." },
  { output: "confidentialite/index.html", meta: pageMeta.privacyFr, noscript: "La politique de confidentialité de Purple Events nécessite JavaScript pour être affichée." },
  { output: "en/privacy/index.html", meta: pageMeta.privacyEn, noscript: "The Purple Events privacy policy requires JavaScript to be displayed." },
  { output: "cookies/index.html", meta: pageMeta.cookiesFr, noscript: "Purple Events n’utilise aucun cookie publicitaire ou analytique dans cette version." },
  { output: "en/cookies/index.html", meta: pageMeta.cookiesEn, noscript: "Purple Events uses no advertising or analytics cookies in this version." },
  { output: "mentions-legales/index.html", meta: pageMeta.legalFr, noscript: "Les mentions légales de Purple Events nécessitent JavaScript pour être affichées." },
  { output: "en/legal-notice/index.html", meta: pageMeta.legalEn, noscript: "The Purple Events legal notice requires JavaScript to be displayed." },
];

const escapeAttribute = (value) => String(value).replaceAll("&", "&amp;").replaceAll('"', "&quot;");
const escapeText = (value) => escapeAttribute(value).replaceAll("<", "&lt;").replaceAll(">", "&gt;");

function setAttribute(html, id, attribute, value) {
  const pattern = new RegExp(`(<[^>]*id="${id}"[^>]*\\b${attribute}=")[^"]*(")`);
  return html.replace(pattern, `$1${escapeAttribute(value)}$2`);
}

function render({ meta, hero, noscript }) {
  let html = base.replace(/<html lang="[^"]+">/, `<html lang="${meta.lang}">`);
  html = html.replace(/<title id="seo-title">[\s\S]*?<\/title>/, `<title id="seo-title">${escapeText(meta.title)}</title>`);
  html = setAttribute(html, "seo-description", "content", meta.description);
  html = setAttribute(html, "seo-robots", "content", meta.robots);
  html = setAttribute(html, "seo-og-title", "content", meta.title);
  html = setAttribute(html, "seo-og-description", "content", meta.description);
  html = setAttribute(html, "seo-og-url", "content", meta.canonical);
  html = setAttribute(html, "seo-og-image", "content", meta.socialImage);
  html = setAttribute(html, "seo-og-image-alt", "content", meta.socialImageAlt);
  html = setAttribute(html, "seo-og-locale", "content", meta.locale);
  html = setAttribute(html, "seo-og-locale-alternate", "content", meta.alternateLocale);
  html = setAttribute(html, "seo-twitter-title", "content", meta.title);
  html = setAttribute(html, "seo-twitter-description", "content", meta.description);
  html = setAttribute(html, "seo-twitter-image", "content", meta.socialImage);
  html = setAttribute(html, "seo-twitter-image-alt", "content", meta.socialImageAlt);
  html = setAttribute(html, "seo-canonical", "href", meta.canonical);
  html = setAttribute(html, "seo-alt-fr", "href", meta.alternates.fr);
  html = setAttribute(html, "seo-alt-en", "href", meta.alternates.en);
  html = setAttribute(html, "seo-alt-default", "href", meta.alternates.default);
  html = html.replace(/<script id="seo-structured-data" type="application\/ld\+json">[\s\S]*?<\/script>/, `<script id="seo-structured-data" type="application/ld+json">${JSON.stringify(structuredData(meta)).replaceAll("<", "\\u003c")}</script>`);
  html = html.replace(/<noscript>[\s\S]*?<\/noscript>/, `<noscript><h1>Purple Events</h1><p>${escapeText(noscript)}</p></noscript>`);
  if (!hero) html = html.replace(/\s*<link id="seo-hero-preload"[^>]+>/, "");
  return html;
}

for (const route of routes) {
  const target = join(root, route.output);
  mkdirSync(dirname(target), { recursive: true });
  writeFileSync(target, render(route), "utf8");
}

console.log(`STATIC_ENTRYPOINTS=${routes.length}`);
