#!/bin/bash

# 1. Faire un git pull avec rebase pour récupérer les modifications distantes
echo "Récupération des modifications du dépôt distant..."
git pull origin main --rebase

# Vérifier si le rebase a échoué à cause de conflits
if [ $? -ne 0 ]; then
    echo "Des conflits ont été détectés. Résolution en prenant les modifications distantes..."

    # 2. Résolution des conflits en prenant la version distante (theirs)
    git diff --name-only --diff-filter=U | while read file; do
        echo "Résolution du conflit dans : $file"
        git checkout --theirs "$file"
        git add "$file"
    done

    # 3. Continuer le rebase après avoir résolu les conflits
    git rebase --continue

    # Vérifier si le rebase a réussi
    if [ $? -eq 0 ]; then
        echo "Le rebase a été effectué avec succès !"
    else
        echo "Le rebase a échoué, vous devez résoudre manuellement certains conflits."
        exit 1
    fi
else
    echo "Aucun conflit détecté. Le rebase a réussi automatiquement."
fi

# 4. Pousser les changements vers GitHub
echo "Poussée des modifications vers GitHub..."
git push -u origin main

# Vérifier si le push a réussi
if [ $? -eq 0 ]; then
    echo "Les modifications ont été poussées avec succès vers GitHub !"
else
    echo "Échec du push vers GitHub."
    exit 1
fi
