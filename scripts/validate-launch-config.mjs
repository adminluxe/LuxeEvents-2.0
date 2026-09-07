import { existsSync, readFileSync } from "node:fs";
import { resolve } from "node:path";

function readEnvFile(path) {
  if (!existsSync(path)) return {};
  return Object.fromEntries(readFileSync(path, "utf8").split(/\r?\n/).flatMap((line) => {
    const value = line.trim();
    if (!value || value.startsWith("#") || !value.includes("=")) return [];
    const separator = value.indexOf("=");
    const key = value.slice(0, separator).trim();
    const raw = value.slice(separator + 1).trim();
    const parsed = /^(['"]).*\1$/.test(raw) ? raw.slice(1, -1) : raw;
    return [[key, parsed]];
  }));
}

const values = {
  ...readEnvFile(resolve(".env.production")),
  ...readEnvFile(resolve(".env.production.local")),
  ...process.env,
};

const required = [
  "VITE_LEGAL_NAME",
  "VITE_LEGAL_ADDRESS",
  "VITE_LEGAL_ENTERPRISE_NUMBER",
  "VITE_LEGAL_EMAIL",
  "VITE_LEGAL_PHONE",
  "VITE_CONTACT_RETENTION_MONTHS",
];

const missing = new Set(required.filter((key) => !String(values[key] || "").trim()));
const failures = [...missing].map((key) => `${key} is missing`);
const privacyEmail = String(values.VITE_PRIVACY_EMAIL || values.VITE_LEGAL_EMAIL || "").trim();
const contactEmail = String(values.VITE_CONTACT_EMAIL || "").trim();
const contactEndpoint = String(values.VITE_CONTACT_ENDPOINT || "").trim();
const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

if (!missing.has("VITE_LEGAL_EMAIL") && !emailPattern.test(String(values.VITE_LEGAL_EMAIL || ""))) failures.push("VITE_LEGAL_EMAIL is invalid");
if (!missing.has("VITE_LEGAL_EMAIL") && !emailPattern.test(privacyEmail)) failures.push("VITE_PRIVACY_EMAIL or VITE_LEGAL_EMAIL must provide a valid privacy contact");
if (contactEmail && !emailPattern.test(contactEmail)) failures.push("VITE_CONTACT_EMAIL is invalid");
if (Boolean(contactEmail) === Boolean(contactEndpoint)) failures.push("configure exactly one of VITE_CONTACT_EMAIL or VITE_CONTACT_ENDPOINT");
if (contactEndpoint && !/^https:\/\//.test(contactEndpoint)) failures.push("VITE_CONTACT_ENDPOINT must use HTTPS");

const retention = Number(values.VITE_CONTACT_RETENTION_MONTHS);
if (!missing.has("VITE_CONTACT_RETENTION_MONTHS") && (!Number.isInteger(retention) || retention < 1 || retention > 60)) failures.push("VITE_CONTACT_RETENTION_MONTHS must be an integer from 1 to 60");

if (failures.length) {
  console.error("PURPLE_LAUNCH_CONFIG=BLOCKED");
  for (const failure of [...new Set(failures)]) console.error(`- ${failure}`);
  process.exit(1);
}

console.log("PURPLE_LAUNCH_CONFIG=PASS");
