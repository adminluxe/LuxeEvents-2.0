#!/usr/bin/env bash
# patch_home_services.sh — Ajout de services + sécurisation du map dans Home.jsx
set -euo pipefail

FILE="src/pages/Home.jsx"
if [[ ! -f "$FILE" ]]; then
  echo "❌ $FILE introuvable !"
  exit 1
fi

patch << 'PATCH'
*** Begin Patch
*** Update File: src/pages/Home.jsx
@@ export default function Home() {
-  const features = t('home.features', { returnObjects: true });
+  const features = t('home.features', { returnObjects: true });
+  const services = t('home.services',    { returnObjects: true });
@@
-            {t('home.services', { returnObjects: true }).map((s, i) => (
+            {Array.isArray(services) ? services.map((s, i) => (
@@
-            )) : null}
+            )) : null}
*** End Patch
PATCH

echo "✅ Home.jsx mis à jour pour services et map sécurisé."
