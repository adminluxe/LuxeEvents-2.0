# Purple Events — Architecture publique

Mise à jour : 7 septembre 2026.

## Source et livraison

- Dépôt canonique : `adminluxe/LuxeEvents-2.0`.
- Branche candidate : `luxeevents-ultra-polish-v1`.
- Application : React 18 et Vite 7, export statique versionné.
- Domaine canonique : `https://purpleevents.fun`.
- Hébergement d’origine : Hostinger ; DNS, proxy et sécurité périmétrique : Cloudflare.

Les adresses, chemins, sauvegardes, commandes de déploiement, diagnostics et procédures de rollback restent dans le kit d’exploitation privé. Ils ne doivent pas être ajoutés à ce dépôt public.

## Routes et indexation

| Route | Langue | Indexation | Rôle |
|---|---|---|---|
| `/` | Français | `index, follow` | Landing principale et `x-default` |
| `/en/` | Anglais | `index, follow` | Landing internationale |
| `/confidentialite/`, `/en/privacy/` | FR / EN | `noindex, follow` | Information vie privée |
| `/cookies/`, `/en/cookies/` | FR / EN | `noindex, follow` | Information cookies et stockage local |
| `/mentions-legales/`, `/en/legal-notice/` | FR / EN | `noindex, follow` | Identité de l’éditeur |

Le build génère un fichier HTML statique par route avec son propre `lang`, title, description, canonical et jeu `hreflang`. Le sitemap ne déclare que les deux landing pages indexables.

## Données et stockage navigateur

- Aucun outil analytique, publicitaire, pixel marketing ou contenu social embarqué n’est chargé.
- La langue est portée par l’URL ; elle n’est pas stockée dans le navigateur.
- Une seule clé `localStorage`, `purple-events-cookie-notice`, mémorise pendant 180 jours maximum la fermeture de l’avis d’information.
- Toute future activation de mesure d’audience ou de marketing exige une nouvelle analyse, un blocage préalable et, si requis, un mécanisme de consentement révocable.

## Gate de configuration production

Le build public passe obligatoirement par `pnpm check:launch`. Il refuse la release si l’identité légale, les contacts, la durée de conservation ou le canal de conversion ne sont pas configurés avec des valeurs définitives.

## Identité visuelle active

- Emblème principal : orchidée pourpre originale sur fond transparent.
- Icônes : dérivés PNG 32, 64, 180, 192 et 512 px du même emblème.
- Signature : `Une initiative Purple Orchid Group` en français et `A Purple Orchid Group initiative` en anglais.
