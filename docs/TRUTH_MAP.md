# Purple Events — Truth Map publique

Mise à jour : 30 septembre 2026.

## Prouvé

- Le nom de marque retenu est **Purple Events**.
- Purple Events est présenté comme une initiative de **Purple Orchid Group**, selon la formulation fournie par le propriétaire du projet.
- Le domaine canonique retenu est `purpleevents.fun`.
- L’adresse annoncée est `14 rue de la Fonderie, L-1531 Luxembourg` ; les contacts annoncés sont `contact@purpleorchidgroup.com`, `support@purpleorchidgroup.com` et `+32 465 22 26 29`.
- Purple Orchid Group est annoncée comme une Sàrl en cours de constitution ; aucune immatriculation RCS n’a été fournie à ce jalon et le site ne doit pas la présenter comme une société déjà enregistrée.
- La branche candidate compile avec Vite et ne livre aucune occurrence de l’ancienne marque ni des preuves commerciales non vérifiées identifiées.
- Le frontend ne charge aucun outil analytique, publicitaire, pixel marketing ou contenu social embarqué.
- Le seul stockage navigateur créé par l’application est la clé fonctionnelle `purple-events-cookie-notice`, après fermeture de l’avis, pour 180 jours maximum.
- Les deux landing pages disposent de routes, canonicals et alternates linguistiques distincts ; les pages juridiques sont exclues de l’indexation.

## Retiré de la version candidate

- Notes, avis, témoignages et noms de clients ou partenaires sans source.
- Chiffres d’activité ou d’expérience sans justificatif.
- Adresses contradictoires et promesse de couverture mondiale.
- Galerie héritée composée d’images dupliquées.
- Audio, photos et logos hérités dont les droits ou l’adéquation à Purple Events ne sont pas établis.
- Anciennes métadonnées, anciens favicons et canonicals LuxeEvents.

## À confirmer avant lancement public

- Identité exacte de l’éditeur juridiquement existant le jour du lancement, forme/statut et identification officielle.
- Territoires effectivement servis et langues prises en charge commercialement.
- Réception effective de la boîte e-mail ou fonctionnement réel de l’endpoint de contact.
- Durée de conservation des demandes et contact d’exercice des droits.
- Propriété ou autorisation écrite pour toute future réalisation, photo, vidéo, avis, logo ou chiffre publié.

## Verrou automatique

La commande `pnpm check:launch` échoue tant que l’identité de l’éditeur, sa forme ou son statut, son adresse, son identification officielle, l’e-mail, le téléphone, la durée de conservation et un canal de conversion réel ne sont pas fournis. Elle rejette aussi les formulations provisoires telles que « en cours de constitution ». Un build de preview peut afficher les champs manquants ; ce build ne doit jamais être déployé publiquement.
