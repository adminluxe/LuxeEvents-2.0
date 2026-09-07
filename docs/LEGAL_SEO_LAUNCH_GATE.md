# Purple Events — Gate juridique, cookies et SEO

Mise à jour : 7 septembre 2026.

Ce document décrit le verrou de publication. Il ne remplace pas un avis juridique professionnel.

## Cookies et stockage

La version candidate n’embarque ni mesure d’audience, ni publicité, ni pixel marketing, ni contenu social tiers. Elle utilise uniquement `localStorage` pour mémoriser la fermeture de l’avis relatif aux cookies pendant 180 jours maximum. La page `/cookies/` et son équivalent anglais décrivent précisément ce mécanisme et les traitements techniques possibles de Cloudflare et Hostinger.

L’ajout futur d’un outil facultatif impose de le bloquer avant consentement, de permettre un retrait aussi simple que l’acceptation et d’actualiser la politique.

Référence : CNPD Luxembourg — https://cnpd.public.lu/fr/dossiers-thematiques/cookies0/cookies/principes-applicables.html

## Informations juridiques requises

Les variables suivantes doivent contenir des informations exactes avant le build public :

```dotenv
VITE_LEGAL_NAME=
VITE_LEGAL_FORM=
VITE_LEGAL_ADDRESS=
VITE_LEGAL_REGISTRATION=
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

`VITE_LEGAL_NAME` doit désigner la personne morale déjà constituée ou la personne physique réellement responsable de la publication le jour du lancement. La mention « Sàrl en cours de constitution » décrit un projet de forme sociale mais ne remplace pas l’identité de l’éditeur ni une immatriculation existante. Le gate rejette donc les formulations provisoires.

Références :

- Guichet.lu — https://guichet.public.lu/fr/entreprises/gestion-juridique-comptabilite/registre-commerce/depots-publications/immatriculation-entreprise-publication-rcs.html
- CNPD Luxembourg — https://cnpd.public.lu/fr/dossiers-thematiques/psp/duree-conservation-donnes-service-paiement/obligation-informer.html

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
