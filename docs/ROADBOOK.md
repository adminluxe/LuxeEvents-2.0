# Purple Events — Roadbook public

Mise à jour : 7 septembre 2026.

## Jalon 1 — vérité du produit — terminé

- [x] Élire le dépôt et la branche de travail.
- [x] Remplacer LuxeEvents par Purple Events.
- [x] Retirer les preuves, chiffres et témoignages non sourcés.
- [x] Mettre en place une expérience bilingue FR/EN.

## Jalon 2 — identité premium — terminé

- [x] Intégrer un visuel héro original optimisé.
- [x] Installer l’emblème orchidée pourpre et ses icônes.
- [x] Ajouter la signature « Une initiative Purple Orchid Group » et son équivalent anglais.
- [x] Ajouter une prise de brief à repli sûr.
- [x] Maintenir un build statique inférieur à 1 MiB.

## Jalon 3 — cookies et SEO — terminé

- [x] Ne charger aucun outil publicitaire, analytique, pixel marketing ou contenu social embarqué.
- [x] Informer sur l’unique stockage local fonctionnel.
- [x] Générer des URL distinctes, canonicals, `hreflang`, métadonnées sociales et données structurées.
- [x] Limiter le sitemap aux deux landing pages indexables.
- [x] Aligner l’autorité de contrôle et les références sur le Luxembourg (CNPD / Guichet.lu).

## Jalon 4 — conformité de publication — bloquant

- [ ] Valider l’identité de l’éditeur juridiquement existant et son identification officielle.
- [ ] Valider la durée de conservation des demandes.
- [ ] Prouver le fonctionnement du canal de contact choisi.
- [ ] Injecter les informations définitives dans la configuration de production.
- [ ] Exécuter `pnpm check:launch` avec succès.

## Jalon 5 — mise en ligne réversible

- [ ] Appliquer le guide d’exploitation privé.
- [ ] Effectuer le backup ciblé et préparer le rollback.
- [ ] Valider le serveur web et le certificat d’origine.
- [ ] Exécuter les smokes avant puis après la bascule DNS web.
- [ ] Vérifier HTTPS public, redirections, routes, SEO et renouvellement du certificat.

Gate public : aucun trafic ne bascule tant que les valeurs légales réelles, le canal de conversion, la recette finale, le backup et le rollback ne sont pas validés.
