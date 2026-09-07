import { existsSync, readdirSync, readFileSync, statSync } from "node:fs";
import { extname, join, relative } from "node:path";

const root = new URL("../dist/", import.meta.url);
const rootPath = root.pathname;
const required = [
  "index.html",
  "en/index.html",
  "confidentialite/index.html",
  "en/privacy/index.html",
  "cookies/index.html",
  "en/cookies/index.html",
  "mentions-legales/index.html",
  "en/legal-notice/index.html",
  "manifest.webmanifest",
  "robots.txt",
  "sitemap.xml",
  "images/apple-touch-icon.png",
  "images/favicon-32.png",
  "images/favicon-64.png",
  "images/purple-events-icon-192.png",
  "images/purple-events-icon-512.png",
  "images/purple-events-hero-v1.webp",
  "images/purple-orchid-emblem-v1.webp",
];
const forbidden = [
  /luxeevents/i,
  /luxeevents\.me/i,
  /trustpilot/i,
  /120\+\s*clients/i,
  /10\s*ans\s*d.expérience/i,
  /4\.[89]\/5/i,
  /Maison D.Or/i,
  /NovaTech/i,
];
const textExtensions = new Set([".html", ".js", ".css", ".json", ".xml", ".txt", ".svg", ".webmanifest"]);

function walk(directory) {
  return readdirSync(directory, { withFileTypes: true }).flatMap((entry) => {
    const path = join(directory, entry.name);
    return entry.isDirectory() ? walk(path) : [path];
  });
}

const failures = [];
for (const file of required) {
  if (!existsSync(join(rootPath, file))) failures.push(`missing required file: ${file}`);
}

const files = walk(rootPath);
const totalBytes = files.reduce((total, file) => total + statSync(file).size, 0);
if (totalBytes > 1024 * 1024) failures.push(`build exceeds 1 MiB: ${totalBytes} bytes`);

const compiledText = files
  .filter((file) => textExtensions.has(extname(file)) || file.endsWith(".webmanifest"))
  .map((file) => readFileSync(file, "utf8"))
  .join("\n");

if (!compiledText.includes("Une initiative Purple Orchid Group")) {
  failures.push("missing French Purple Orchid Group attribution");
}

if (!compiledText.includes("A Purple Orchid Group initiative")) {
  failures.push("missing English Purple Orchid Group attribution");
}

if (!compiledText.includes("purple-events-cookie-notice")) {
  failures.push("missing functional storage disclosure");
}

const seoChecks = [
  { file: "index.html", lang: "fr", canonical: "https://purpleevents.fun/", robots: "index, follow" },
  { file: "en/index.html", lang: "en", canonical: "https://purpleevents.fun/en/", robots: "index, follow" },
  { file: "confidentialite/index.html", lang: "fr", canonical: "https://purpleevents.fun/confidentialite/", robots: "noindex, follow" },
  { file: "en/privacy/index.html", lang: "en", canonical: "https://purpleevents.fun/en/privacy/", robots: "noindex, follow" },
  { file: "cookies/index.html", lang: "fr", canonical: "https://purpleevents.fun/cookies/", robots: "noindex, follow" },
  { file: "en/cookies/index.html", lang: "en", canonical: "https://purpleevents.fun/en/cookies/", robots: "noindex, follow" },
  { file: "mentions-legales/index.html", lang: "fr", canonical: "https://purpleevents.fun/mentions-legales/", robots: "noindex, follow" },
  { file: "en/legal-notice/index.html", lang: "en", canonical: "https://purpleevents.fun/en/legal-notice/", robots: "noindex, follow" },
];

for (const check of seoChecks) {
  const html = readFileSync(join(rootPath, check.file), "utf8");
  if (!html.includes(`<html lang="${check.lang}">`)) failures.push(`${check.file} has incorrect lang`);
  if (!html.includes(`rel="canonical" href="${check.canonical}"`)) failures.push(`${check.file} has incorrect canonical`);
  if (!html.includes(`name="robots" content="${check.robots}`)) failures.push(`${check.file} has incorrect robots directive`);
  if (!html.includes('property="og:image" content="https://purpleevents.fun/images/purple-events-hero-v1.webp"')) failures.push(`${check.file} is missing the social preview image`);
  if (!html.includes('name="twitter:card" content="summary_large_image"')) failures.push(`${check.file} has an incorrect Twitter card type`);
  if (!html.includes("hreflang=\"fr\"") || !html.includes("hreflang=\"en\"") || !html.includes("hreflang=\"x-default\"")) {
    failures.push(`${check.file} is missing reciprocal hreflang links`);
  }
}

const sitemap = readFileSync(join(rootPath, "sitemap.xml"), "utf8");
if (!sitemap.includes("https://purpleevents.fun/en/")) failures.push("sitemap is missing the English landing page");
if (!sitemap.includes("xmlns:xhtml=")) failures.push("sitemap is missing the hreflang namespace");

for (const file of files) {
  if (!textExtensions.has(extname(file)) && !file.endsWith(".webmanifest")) continue;
  const value = readFileSync(file, "utf8");
  for (const pattern of forbidden) {
    if (pattern.test(value)) failures.push(`${relative(rootPath, file)} contains ${pattern}`);
  }
}

if (failures.length) {
  console.error("PURPLE_STATIC_QA=FAIL");
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}

console.log("PURPLE_STATIC_QA=PASS");
console.log(`FILES=${files.length}`);
console.log(`TOTAL_BYTES=${totalBytes}`);
