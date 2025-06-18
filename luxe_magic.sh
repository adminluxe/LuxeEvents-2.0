#!/usr/bin/env bash

# --------------------------------------------------
#!/usr/bin/env bash

# ==================================================
# ✨ LuxeEvents Magic Script — LUXURY EXPERIENCE ✨
# ==================================================
# Automatisations :
# 1️⃣ SEO & Social Meta (Open Graph + Twitter Cards)
# 2️⃣ Favicon & Assets injection
# 3️⃣ Google Analytics (ou Plausible) snippet
# 4️⃣ reCAPTCHA v3 (invisible) setup stub
# 5️⃣ UptimeRobot monitor creation via API
# 6️⃣ Clean & rebuild
# ==================================================

set -euo pipefail
IFS=$'
'\	

# -------------------- CONFIGURATION --------------------
PROJECT_DIR="/home/tontoncestcarre/luxeevents-frontend"
INDEX_HTML="${PROJECT_DIR}/public/index.html"
ENV_FILE="${PROJECT_DIR}/.env"
REC_KEY="YOUR_RECAPTCHA_SITE_KEY"
REC_SECRET="YOUR_RECAPTCHA_SECRET_KEY"
GA_ID="UA-XXXXX-Y"
UPTIMEROBOT_API_KEY="YOUR_UPTIMEROBOT_API_KEY"
MONITOR_URL="https://luxeevents.me"
MONITOR_NAME="LuxeEvents Prod"

# -------------------- 1) SEO & SOCIAL META --------------------
echo "🩷 Injecting SEO & Open Graph meta tags into index.html..."
# Backup
cp "$INDEX_HTML" "$INDEX_HTML.bak"
# Insert in head
sed -i "/<title>/a \    <!-- Open Graph / Facebook -->\n    <meta property=\"og:title\" content=\"LuxeEvents – Le luxe à la portée de Tous!\" />\n    <meta property=\"og:description\" content=\"Créez et vivez des événements chics, accessibles et haut de gamme.\" />\n    <meta property=\"og:image\" content=\"https://luxeevents.me/assets/og-image.jpg\" />\n    <meta property=\"og:url\" content=\"https://luxeevents.me\" />\n    <meta name=\"twitter:card\" content=\"summary_large_image\" />" "$INDEX_HTML"

# -------------------- 2) FAVICON & ASSETS --------------------
echo "🖼 Ensuring favicon and manifest references..."
# After meta tags
sed -i "/<meta name=\"viewport\"/a \    <link rel=\"icon\" href=\"/favicon.ico\" />\n    <link rel=\"manifest\" href=\"/manifest.json\" />" "$INDEX_HTML"

# -------------------- 3) GOOGLE ANALYTICS SNIPPET --------------------
echo "📊 Injecting Google Analytics snippet (or Plausible)..."
sed -i "/<\/head>/i \    <!-- Google Analytics -->\n    <script async src=\"https://www.googletagmanager.com/gtag/js?id=${GA_ID}\"></script>\n    <script>window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','${GA_ID}');</script>" "$INDEX_HTML"

# -------------------- 4) reCAPTCHA v3 SETUP --------------------
echo "🔐 Setting up reCAPTCHA v3 variables in .env..."
cat <<EOF >> "$ENV_FILE"
REACT_APP_RECAPTCHA_SITE_KEY=${REC_KEY}
RECAPTCHA_SECRET_KEY=${REC_SECRET}
EOF

# -------------------- 5) UPTIMEROBOT MONITOR --------------------
echo "⏱ Creating UptimeRobot monitor via API..."
API_URL="https://api.uptimerobot.com/v2/newMonitor"
# Ensure variables exist
if [[ -z "$UPTIMEROBOT_API_KEY" || "$UPTIMEROBOT_API_KEY" == "YOUR_UPTIMEROBOT_API_KEY" ]]; then
  echo "⚠️ UptimeRobot API key not set, skipping monitor creation."
else
  RESPONSE=$(curl -s -X POST "$API_URL" \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -d "api_key=${UPTIMEROBOT_API_KEY}&format=json&monitorFriendlyName=$(echo $MONITOR_NAME | sed 's/ /%20/g')&monitorURL=${MONITOR_URL}&monitorType=1")
  echo "🚨 UptimeRobot response: $RESPONSE"
fi

# -------------------- 6) CLEAN & REBUILD & REBUILD --------------------
echo "🧹 Cleaning node_modules and rebuilding..."
cd "$PROJECT_DIR"
rm -rf node_modules build
npm install
npm run build

# -------------------- FIN --------------------
echo "
✅ LuxeEvents Magic setup complete!
"

exit 0
