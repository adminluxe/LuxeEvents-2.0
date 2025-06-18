#!/bin/bash
echo "🧹 Nettoyage des gros backups .tar.gz du repo Git"

# 1. Supprimer les backups volumineux de l'index Git (sans toucher aux fichiers locaux)
git rm --cached luxeevents-frontend-backup-*.tar.gz

# 2. Ajouter une règle dans .gitignore pour ignorer les backups à l'avenir
if ! grep -q 'luxeevents-frontend-backup-*.tar.gz' .gitignore; then
    echo "luxeevents-frontend-backup-*.tar.gz" >> .gitignore
    echo "Ajouté dans .gitignore : luxeevents-frontend-backup-*.tar.gz"
else
    echo "La règle .gitignore pour backups est déjà présente"
fi

# 3. Réécrire le dernier commit pour retirer ces fichiers (sans changer le message)
git commit --amend --no-edit

# 4. Forcer le push pour mettre à jour le dépôt distant proprement
echo "⚠️ Attention, le push sera forcé pour écraser l'historique local corrigé."
read -p "Tu es prêt à pousser ? (y/n) : " answer
if [[ "$answer" == "y" ]]; then
    git push origin main --force
else
    echo "Push annulé. Pense à pousser plus tard avec : git push origin main --force"
fi

echo "✔️ Script terminé, dépôt nettoyé des gros fichiers !"
