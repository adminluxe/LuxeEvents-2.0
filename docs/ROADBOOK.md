# Purple Events — Roadbook de livraison

Mise à jour : 7 septembre 2026.

## Jalon 1 — vérité technique — terminé

- [x] Sortir le T310 de l’architecture.
- [x] Confirmer le VPS Hostinger et son identité.
- [x] Prouver l’absence de vhost/service/certificat Purple Events.
- [x] Exporter et vérifier les sources GitHub frontend/backend.
- [x] Écarter l’alias de dépôt frontend et élire le dépôt canonique.
- [x] Évaluer `main`, la branche premium et le backend historique.

## Jalon 2 — socle Purple Events — terminé localement

- [x] Créer `luxeevents-ultra-polish-v1` depuis `feat/pimp-phase1-hero-services`.
- [x] Remplacer la marque, les canonicals et les métadonnées.
- [x] Mettre en place une expérience FR/EN.
- [x] Retirer les preuves, témoignages et chiffres non sourcés.
- [x] Isoler tous les anciens assets hors du build public.
- [x] Intégrer un visuel héro original optimisé.
- [x] Remplacer le pictogramme abstrait par l’emblème orchidée pourpre validé pour la preview.
- [x] Ajouter l’affiliation « Une initiative Purple Orchid Group » au footer FR et son équivalent EN.
- [x] Ajouter une prise de brief à repli sûr.
- [x] Réduire le build de référence d’environ 29 Mo à moins de 0,5 Mo.
- [x] Passer lint, build et scan anti-régression LuxeEvents.

## Jalon 3 — vérité commerciale et conformité — bloquant lancement

- [ ] Valider l’identité légale et les coordonnées de publication.
- [ ] Valider la zone géographique et les prestations réellement vendues.
- [ ] Créer/valider la boîte de réception ou l’endpoint de formulaire.
- [x] Implémenter les mentions légales, la politique de confidentialité et la politique cookies en FR/EN.
- [x] Ne charger aucun outil publicitaire, analytique, pixel marketing ou contenu social embarqué.
- [x] Ajouter un avis d’information honnête pour l’unique stockage local fonctionnel.
- [ ] Injecter et valider les informations légales réelles dans la configuration de production.
- [ ] Valider les éléments de preuve autorisés, s’il y en a.

## Jalon 4 — preview VPS privée — en cours

- [x] Rejouer le build sur le VPS avec Node 20 et pnpm 8.15.4 en espace isolé.
- [x] Créer une release locale non exposée publiquement.
- [x] Ouvrir un tunnel SSH depuis le Toshiba.
- [x] Confirmer visuellement la langue anglaise et le repli local « Copier mon brief ».
- [x] Revalider le build V5 sur une release privée isolée du VPS.
- [x] Confirmer les statuts 200 de l’index, du visuel héro, de l’orchidée et de `robots.txt`.
- [x] Confirmer que l’attribution Purple Orchid Group est incluse dans le bundle.
- [ ] Contrôler navigation, langue, formulaire, accessibilité, poids et erreurs console.
- [ ] Produire le rapport de recette et le rollback avant vhost.

## Jalon 4 bis — SEO technique — terminé localement

- [x] Produire des URL indexables séparées `/` et `/en/`.
- [x] Ajouter title, description, canonical, Open Graph, `lang` et `hreflang` réciproques.
- [x] Ajouter une image de partage Open Graph/Twitter issue du visuel héro validé.
- [x] Générer huit points d’entrée statiques pour les deux langues et les pages juridiques.
- [x] Limiter le sitemap aux deux landing pages indexables.
- [x] Mettre les pages juridiques en `noindex, follow`.
- [x] Ajouter les données structurées `Organization` et `WebPage` sans avis, note ni promesse inventés.
- [x] Passer le contrôle statique SEO/route/cookies du build.

## Jalon 5 — red button public

- [ ] Backup ciblé + manifeste SHA-256.
- [ ] Vhost complet + `nginx -t`.
- [ ] Certificat origine valide.
- [ ] Smoke via résolution forcée sur le VPS.
- [ ] Bascule des seuls DNS web Cloudflare.
- [ ] Validation HTTPS publique et Cloudflare `Full (strict)`.
- [ ] Rollback testé, bundle final et checksums.

Gate public : aucun trafic ne bascule tant que les valeurs légales réelles, le canal de conversion, la recette finale, le backup et le rollback ne sont pas validés. `pnpm check:launch` impose techniquement ce verrou.
