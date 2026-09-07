# Purple Events — Truth Map

Mise à jour : 7 septembre 2026.

## Prouvé

- Le nom de marque retenu est **Purple Events**.
- Purple Events est présenté comme une initiative de **Purple Orchid Group**, selon la formulation fournie par le propriétaire du projet.
- Le domaine `purpleevents.fun` est acquis chez Amen et délégué à `chuck.ns.cloudflare.com` et `joyce.ns.cloudflare.com`.
- Les contrôles publics interrogés après délégation ne renvoient plus d’enregistrement DS hérité.
- Le VPS cible est le serveur Hostinger `srv1037391`, accessible avec `afripayadmin@194.164.72.250`.
- Aucun vhost, certificat ou service Purple Events n’était configuré lors de la découverte initiale.
- `adminluxe/LuxeEvents-2.0` et l’ancienne adresse `adminluxe/luxeevents-frontend` résolvent vers le même historique, le même commit et le même arbre Git.
- La branche `feat/pimp-phase1-hero-services` descend de `main`, contient déjà `fix/services-data` et constitue le socle historique le plus récent.
- La preview Purple Events compile avec Vite et ne livre aucune occurrence de LuxeEvents ni des preuves commerciales non vérifiées identifiées.
- La release privée V5 du VPS a répondu 200 pour l’index, le visuel héro, l’emblème orchidée et `robots.txt`, sans action DNS, vhost, service ou chemin de production.
- Le frontend ne charge aucun outil analytique, publicitaire, pixel marketing ou contenu social embarqué.
- Le seul stockage navigateur créé par l’application est la clé fonctionnelle `purple-events-cookie-notice`, après fermeture de l’avis, pour 180 jours maximum.
- Les deux landing pages disposent de routes, canonicals et alternates linguistiques distincts ; les six pages juridiques sont publiables mais exclues de l’indexation.

## Retiré de la version livrée

- Notes Google et Trustpilot sans source.
- `120+ clients`, `10 ans d’expérience` et tout chiffre sans justificatif.
- Témoignages et noms de clients/partenaires non vérifiés.
- Adresses contradictoires Paris/Bruxelles et promesse de couverture mondiale.
- Galerie héritée : huit vignettes étaient la même image dupliquée.
- Audio, photos et logos hérités dont les droits ou l’adéquation à Purple Events ne sont pas établis.
- Ancien service worker, anciennes métadonnées, anciens favicons et canonicals LuxeEvents.

## À confirmer avant lancement public

- Identité légale complète de l’éditeur et adresse de publication.
- Territoires effectivement servis et langues prises en charge commercialement.
- Canal de conversion : endpoint sécurisé ou boîte e-mail Purple Events réellement active.
- Responsable de traitement, durée de conservation et contact d’exercice des droits.
- Liste exacte des prestations commercialisées et limites de périmètre.
- Recherche d’antériorité de l’emblème orchidée avant dépôt de marque ou usage institutionnel irréversible.
- Propriété ou autorisation écrite pour toute future réalisation, photo, vidéo, avis, logo ou chiffre publié.
- Politique de transition de `luxeevents.me` vers `purpleevents.fun`.

## Verrou automatique

La commande `pnpm check:launch` doit échouer tant que l’identité de l’éditeur, l’adresse, le numéro d’entreprise/TVA, l’e-mail, le téléphone, la durée de conservation et un canal de conversion réel ne sont pas fournis. Un build de preview peut afficher les champs manquants ; ce build ne doit jamais être déployé publiquement.
