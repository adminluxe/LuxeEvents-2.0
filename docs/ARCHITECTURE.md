# Purple Events — Architecture

Mise à jour : 7 septembre 2026.

## Chaîne cible

```text
Toshiba (pilotage)
  → GitHub adminluxe/LuxeEvents-2.0
  → branche luxeevents-ultra-polish-v1
  → build Vite statique versionné
  → release isolée sur VPS Hostinger srv1037391
  → vhost NGINX purpleevents.fun
  → origine HTTPS avec certificat valide
  → proxy Cloudflare en mode Full (strict)
  → purpleevents.fun
```

## État actuel

| Couche | État | Décision |
|---|---|---|
| Registrar | Amen | Délégation Cloudflare enregistrée |
| DNS autoritatif | Cloudflare | NS actifs, DS hérité absent lors du dernier contrôle |
| A/AAAA web | Ancienne origine Amen importée | Ne pas basculer vers le VPS avant vhost + certificat + smoke |
| E-mail | Enregistrements Amen importés | MX/TXT à préserver ; CNAME mail non web en DNS-only |
| Dépôt frontend | `adminluxe/LuxeEvents-2.0` | Canonique |
| Branche de base | `feat/pimp-phase1-hero-services` | Élue car descendante de `main` et plus récente |
| Branche Purple | `luxeevents-ultra-polish-v1` | Créée localement ; aucun push distant à ce jalon |
| VPS | `srv1037391` | Aucun service ou vhost Purple Events muté à ce jalon |
| Backend historique | `adminluxe/luxeevents-backend` | Refusé pour production en l’état |

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
- La langue est portée par l’URL ; elle n’est plus stockée dans le navigateur.
- Une seule clé `localStorage`, `purple-events-cookie-notice`, mémorise pendant 180 jours maximum la fermeture de l’avis d’information.
- Toute future activation de mesure d’audience ou de marketing exige une nouvelle analyse, un blocage préalable et, si requis, un mécanisme de consentement révocable.

## Gate de configuration production

Le build public passe obligatoirement par `pnpm check:launch`. Le script refuse la release si l’identité légale, les contacts, la conservation ou le canal de conversion ne sont pas configurés. Les valeurs restent fournies par l’environnement de build et ne sont pas inventées dans le dépôt.

## Identité visuelle active

- Emblème principal : orchidée pourpre originale sur fond transparent, utilisée dans le header, le footer et la page de confidentialité.
- Icônes : dérivés PNG 32, 64, 180, 192 et 512 px produits depuis le même emblème.
- Signature de groupe : `Une initiative Purple Orchid Group` en français et `A Purple Orchid Group initiative` en anglais.

## Déploiement réversible prévu

1. Capturer l’état NGINX, les certificats, les ports et les processus sans déclencher de daemon.
2. Sauvegarder les fichiers explicitement ciblés avec manifeste SHA-256.
3. Installer une release immuable dans un nouveau dossier Purple Events.
4. Servir d’abord sur une adresse locale et exécuter les smokes.
5. Créer le vhost depuis un fichier complet, tester `nginx -t`, puis recharger.
6. Émettre et vérifier le certificat d’origine.
7. Basculer seulement les enregistrements web Cloudflare vers `194.164.72.250`.
8. Passer Cloudflare en `Full (strict)` après preuve HTTPS origine.
9. Conserver la release précédente et un script de rollback atomique.

Le backend historique ne doit jamais être démarré : sa route `/admin` est sans authentification, son rendu de leads n’échappe pas les entrées et ses routes de contact sont incohérentes.
