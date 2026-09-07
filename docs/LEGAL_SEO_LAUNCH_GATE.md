# Purple Events — Gate juridique, cookies et SEO

Mise à jour : 7 septembre 2026.

Ce document décrit le verrou de publication. Il ne remplace pas un avis juridique professionnel.

## Cookies et stockage

La version candidate n’embarque ni mesure d’audience, ni publicité, ni pixel marketing, ni contenu social tiers. Elle utilise uniquement `localStorage` pour mémoriser la fermeture de l’avis relatif aux cookies pendant 180 jours maximum. La page `/cookies/` et son équivalent anglais décrivent précisément ce mécanisme et les traitements techniques possibles de Cloudflare et Hostinger.

L’ajout futur d’un outil facultatif impose de le bloquer avant consentement, de permettre un retrait aussi simple que l’acceptation et d’actualiser la politique.

Référence : Autorité de protection des données belge — https://www.autoriteprotectiondonnees.be/citoyen/cookie

## Informations juridiques requises

Les variables suivantes doivent contenir des informations exactes avant le build public :

```dotenv
VITE_LEGAL_NAME=
VITE_LEGAL_ADDRESS=
VITE_LEGAL_ENTERPRISE_NUMBER=
VITE_LEGAL_EMAIL=
VITE_LEGAL_PHONE=
VITE_PRIVACY_EMAIL=
VITE_CONTACT_RETENTION_MONTHS=
```

Un seul canal de conversion doit être activé :

```dotenv
VITE_CONTACT_EMAIL=
# ou
VITE_CONTACT_ENDPOINT=https://...
```

Références :

- SPF Économie — https://economie.fgov.be/fr/themes/line/commerce-electronique/vente-par-internet/site-dentreprise-et-comptes
- Autorité de protection des données — https://www.autoriteprotectiondonnees.be/citoyen/declaration-de-protection-des-donnees-en-bref

## SEO vérifié dans le build

- Deux URL de landing distinctes : `/` et `/en/`.
- `lang`, title, description et canonical propres à chaque URL.
- `hreflang` réciproques `fr`, `en` et `x-default` dans chaque point d’entrée et dans le sitemap.
- Open Graph/Twitter cohérent avec la langue et visuel de partage issu du héro validé.
- Données structurées `Organization` et `WebPage` sans preuve commerciale inventée.
- Pages juridiques en `noindex, follow` et absentes du sitemap.
- `robots.txt` référence le sitemap public.

Références Google Search Central :

- https://developers.google.com/search/docs/specialty/international/localized-versions
- https://developers.google.com/search/docs/appearance/title-link
- https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data

## Commandes de validation

Preview sans secrets de production :

```bash
corepack pnpm@8.15.4 check
```

Release publique, uniquement avec les vraies valeurs :

```bash
corepack pnpm@8.15.4 check:launch
```

Si une valeur requise manque ou si le canal de conversion est ambigu, `check:launch` s’arrête avant le build public.
