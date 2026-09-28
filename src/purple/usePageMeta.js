import { useEffect } from "react";
import { structuredData } from "./pageMeta.js";

function setContent(selector, value) {
  const element = document.querySelector(selector);
  if (element) element.setAttribute("content", value);
}

function setHref(selector, value) {
  const element = document.querySelector(selector);
  if (element) element.setAttribute("href", value);
}

export default function usePageMeta(meta) {
  useEffect(() => {
    document.documentElement.lang = meta.lang;
    document.title = meta.title;
    setContent("#seo-description", meta.description);
    setContent("#seo-robots", meta.robots);
    setContent("#seo-og-title", meta.title);
    setContent("#seo-og-description", meta.description);
    setContent("#seo-og-url", meta.canonical);
    setContent("#seo-og-image", meta.socialImage);
    setContent("#seo-og-image-alt", meta.socialImageAlt);
    setContent("#seo-og-locale", meta.locale);
    setContent("#seo-og-locale-alternate", meta.alternateLocale);
    setContent("#seo-twitter-title", meta.title);
    setContent("#seo-twitter-description", meta.description);
    setContent("#seo-twitter-image", meta.socialImage);
    setContent("#seo-twitter-image-alt", meta.socialImageAlt);
    setHref("#seo-canonical", meta.canonical);
    setHref("#seo-alt-fr", meta.alternates.fr);
    setHref("#seo-alt-en", meta.alternates.en);
    setHref("#seo-alt-default", meta.alternates.default);

    const schema = document.querySelector("#seo-structured-data");
    if (schema) schema.textContent = JSON.stringify(structuredData(meta));
  }, [meta]);
}
