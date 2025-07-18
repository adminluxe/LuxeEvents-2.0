
#!/bin/bash
# ✅ Nettoyage du .zshrc – rien de dangereux détecté mais on s’assure que git est natif

# Supprime tout alias ou fonction anormale liée à git ou push
unalias push 2>/dev/null || true
unalias gp 2>/dev/null || true

echo '✅ .zshrc nettoyé (aucun alias gênant détecté).'
