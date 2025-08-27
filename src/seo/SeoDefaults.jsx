import { Helmet } from "react-helmet";

export default function SeoDefaults({ title, description, path="/" }){
  const site = "https://luxeevents.me";
  const full = title ? `${title} | LuxeEvents` : "LuxeEvents — Le luxe à la portée de tous";
  const url = site + path;
  const desc = description || "Événements haut de gamme, expérience inoubliable, design d'exception.";
  return (
    <Helmet>
      <title>{full}</title>
      <meta name="description" content={desc} />
      <link rel="canonical" href={url} />
      <meta property="og:title" content={full} />
      <meta property="og:description" content={desc} />
      <meta property="og:url" content={url} />
      <meta property="og:type" content="website" />
    </Helmet>
  );
}
