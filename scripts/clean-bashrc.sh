
#!/bin/bash
# ✅ Nettoyage du .bashrc – suppression du hijack git push personnalisé

# Supprime la fonction git() personnalisée (elle causait l'appel à push.sh)
sed -i '/^git()/,/^}/d' ~/.bashrc

# Recharge le fichier .bashrc
source ~/.bashrc

echo '✅ .bashrc nettoyé : commande git push restaurée.'
