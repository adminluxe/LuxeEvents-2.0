#!/usr/bin/env bash
# =================================================================================
# Tonton’s Page-Scaffolder 2.0  
# Bash-compatible et sans modifier Zsh funky
# =================================================================================

SITE_DIR="${1:-./src/pages}"
mkdir -p "$SITE_DIR"

# Définition des pages : slug|title
declare -a PAGES=(
  "services|Services & Offres"
  "about|À propos"
  "blog|Blog & Actualités"
  "cases|Études de cas"
  "contact|Contact avancé"
)

echo "🛠️  Scaffolding pages in ${SITE_DIR} …"

for entry in "${PAGES[@]}"; do
  slug="${entry%%|*}"
  title="${entry#*|}"
  filepath="${SITE_DIR}/${slug}.md"

  # Si le fichier existe déjà, on lève un avertissement
  if [[ -f "$filepath" ]]; then
    echo "⚠️  Page déjà existante : ${filepath}, on la conserve."
    continue
  fi

  # Génération du contenu complet selon le slug
  case "$slug" in
    services)
      cat > "$filepath" <<EOF
---
title: "${title}"
slug: "/${slug}"
tags: [forfaits, tarifs, faqs]
layout: page
---

# ${title}

Bienvenue dans l’univers de LuxeEvents, où chaque prestation est un écrin sur mesure pour vos rêves les plus dorés.

## Nos forfaits

| Forfait       | Description                         | Tarif indicatif      |
|---------------|-------------------------------------|----------------------|
| **Essentiel** | Coordination jour J + déco basique  | à partir de 2 500 €  |
| **Signature** | Gestion complète + design sur-mesure| à partir de 5 000 €  |
| **Prestige**  | Concierge 24/7 + extras VIP         | sur devis            |

## FAQs par offre

### Forfait Essentiel  
**Q : Quels services sont inclus ?**  
R : Réunion de cadrage, coordination le jour J, installation et désinstallation.  

### Forfait Signature  
**Q : Peut-on personnaliser la papeterie ?**  
R : Absolument ! Invitations, menus et signalétique, tout est à votre image.  

### Forfait Prestige  
**Q : Concierge 24/7 ?**  
R : Oui, un assistant dédié disponible jour et nuit pour répondre à tous vos souhaits.  

---

> **Envie d’un devis précis ?**  
> [Demandez votre devis gratuit](mailto:contact@luxeevents.me?subject=Devis%20LuxeEvents) ou **réservez votre date** dès maintenant. ✨
EOF
      ;;
    about)
      cat > "$filepath" <<EOF
---
title: "${title}"
slug: "/${slug}"
tags: [histoire, équipe, valeurs]
layout: page
---

# ${title}

## Notre histoire  
Tout a commencé en 2015, dans un petit atelier baigné de lumière dorée… À force d’audace et de passion, LuxeEvents est devenu le complice de vos plus beaux instants.  

## L’équipe  
- **Tonton** : capitaine visionnaire, cœur battant du projet.  
- **Clara** : directrice artistique, alchimiste des ambiances.  
- **Maxime** : logisticien, maître d’orchestre des coulisses.  

## Nos valeurs  
1. **Excellence** : chaque détail compte.  
2. **Écoute** : vos envies sont notre boussole.  
3. **Durabilité** : engagement éco-responsable à chaque étape.  

## Behind-the-scenes  
![Atelier LuxeEvents](../assets/atelier-team.jpg)  
_Dans les coulisses, nos réunions effervescentes dessinent vos rêves sur le papier._  
EOF
      ;;
    blog)
      cat > "$filepath" <<EOF
---
title: "${title}"
slug: "/${slug}"
tags: [articles, conseils, retours]
layout: page
---

# ${title}

Bienvenue dans notre carnet de tendances ! Chaque mois, nos experts partagent :

- **Conseils déco** : les couleurs phares, les textures qui dansent.  
- **Témoignages clients** : récits vivants de cérémonies inoubliables.  
- **Actualités événementielles** : les nouveautés du secteur et nos coups de cœur.  

---

### Derniers articles

1. **Palette 2025** : comment marier or et ivoire avec élégance  
2. **Planifier son mariage en 6 mois** : le guide express  
3. **Entretien avec Clara** : secrets de la mise en lumière  

> Tu as une question ou un sujet à suggérer ?  
> Écris-nous à [blog@luxeevents.me](mailto:blog@luxeevents.me)
EOF
      ;;
    cases)
      cat > "$filepath" <<EOF
---
title: "${title}"
slug: "/${slug}"
tags: [portfolio, témoignages, métriques]
layout: page
---

# ${title}

Plongez dans nos réalisations les plus marquantes, où chaque événement se mesure en émotions :

---

## Mariage Champêtre de Julie & Marc  
- **Lieu** : Domaine des Cèdres  
- **Invités** : 120  
- **Témoignage** :  
  > “Un conte moderne, orchestré avec brio !” – Julie  
- **Métriques** :  
  - Satisfaction générale : 98 %  
  - Réduction du gaspillage : 40 % grâce à notre gestion éco-responsable  

---

## Gala d’entreprise TechInnovation  
- **Participants** : 300  
- **Objectif** : Lancement de produit  
- **Valorisation médiatique** : 20+ publications  
- **Témoignage** :  
  > “Une scénographie futuriste tout en simplicité.” – CEO TechInnovation  

> **Voir le portfolio complet**  
> [Télécharger le PDF](../assets/portfolio-luxeevents.pdf)
EOF
      ;;
    contact)
      cat > "$filepath" <<EOF
---
title: "${title}"
slug: "/${slug}"
tags: [formulaire, crm]
layout: page
---

# ${title}

Prêt à écrire votre histoire ? Remplissez ce formulaire, nous vous recontactons sous 24 h :

<form action="https://api.yourcrm.com/leads" method="POST">
  <label>Nom complet <input type="text" name="name" required></label>
  <label>Email <input type="email" name="email" required></label>
  <label>Téléphone <input type="tel" name="phone"></label>
  <label>Date souhaitée <input type="date" name="date"></label>
  <label>Budget estimé <input type="number" name="budget" min="0" step="100"></label>
  <label>Votre message <textarea name="message" rows="4"></textarea></label>
  <button type="submit" class="btn-luxe">Envoyer ma demande</button>
</form>

> Nous intégrons automatiquement vos infos dans notre CRM pour un suivi personnalisé !
EOF
      ;;
  esac

  echo "✅ Générée : ${filepath}"
done

echo "🎉 Toutes les pages ont été créées !"
