---
title: "Contact avancé"
slug: "/contact"
tags: [formulaire, crm]
layout: page
---

# Contact avancé

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
