#!/bin/bash

echo "🔍 Vérification de la structure JSX dans le projet LuxeEvents..."

ERRORS=0

# 1. Vérifie les balises <div> non fermées dans les fichiers .jsx
echo "📦 Vérification des balises <div> non fermées..."
grep -rn "<div" src | grep -v "/\*" | while read -r line; do
  FILE=$(echo "$line" | cut -d: -f1)
  COUNT_OPEN=$(grep -o "<div" "$FILE" | wc -l)
  COUNT_CLOSE=$(grep -o "</div>" "$FILE" | wc -l)
  if [ "$COUNT_OPEN" -ne "$COUNT_CLOSE" ]; then
    echo "❌ $FILE: <div> non équilibrés ($COUNT_OPEN ouverts, $COUNT_CLOSE fermés)"
    ERRORS=$((ERRORS+1))
  fi
done

# 2. Détecte les doublons suspects <div className="absolute ...
echo "🧱 Recherche de doublons <div className=\"absolute..."
grep -rn '<div className="absolute' src | sort | uniq -d | while read -r match; do
  echo "⚠️  Doublon suspect : $match"
  ERRORS=$((ERRORS+1))
done

# 3. Vérifie la présence de JSX après chaque return (
echo "🧪 Vérification de la cohérence des return ("
grep -rn "return (" src | while read -r line; do
  FILE=$(echo "$line" | cut -d: -f1)
  LINE_NUM=$(echo "$line" | cut -d: -f2)
  NEXT_LINE=$((LINE_NUM+1))
  NEXT_CONTENT=$(sed -n "${NEXT_LINE}p" "$FILE" | tr -d '[:space:]')
  if ! echo "$NEXT_CONTENT" | grep -q '^<'; then
    echo "❌ $FILE:$LINE_NUM → return sans JSX sur la ligne suivante → $NEXT_CONTENT"
    ERRORS=$((ERRORS+1))
  fi
done

if [ "$ERRORS" -eq 0 ]; then
  echo "✅ Aucune erreur critique JSX détectée."
else
  echo "🚨 Total erreurs potentielles détectées : $ERRORS"
fi
