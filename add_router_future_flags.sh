#!/usr/bin/env bash
# add_router_future_flags.sh — Ajoute les future flags v7 dans votre RouterProvider
set -euo pipefail

FILE="src/main.jsx"  # ou index.jsx, App.jsx, selon votre projet
if [[ ! -f "$FILE" ]]; then
  echo "❌ $FILE introuvable ! Ajustez le chemin dans le script."
  exit 1
fi

# 1) Si vous utilisez createBrowserRouter(...)
#    on injecte l'option future: { v7_startTransition: true, v7_relativeSplatPath: true }
sed -i "/createBrowserRouter(/,/\)/s|{ *|{ future: { v7_startTransition: true, v7_relativeSplatPath: true }, |" "$FILE"

# 2) Si vous utilisez <RouterProvider router={router} …>
#    on ajoute le prop future={…}
sed -i "s|<RouterProvider \\(.*\\) router={\\([^}]*\\)}|<RouterProvider \\1 router={\\2} future={{ v7_startTransition: true, v7_relativeSplatPath: true }}|" "$FILE"

echo "✅ Options future flags injectées dans $FILE"
