#!/usr/bin/env bash
set -euo pipefail

# Charge les variables d'env depuis .env si présent
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Defaults si pas dans .env
: "${FB_PIXEL_ID:=YOUR_FB_PIXEL_ID}"
: "${LI_PARTNER_ID:=YOUR_LI_PARTNER_ID}"

echo "📈 Setup Tracking & Ads (non interactif)…"
echo " • Facebook Pixel ID   = $FB_PIXEL_ID"
echo " • LinkedIn Partner ID = $LI_PARTNER_ID"

# 1) Injection du FB Pixel
sed -i "/<Helmet>/a \
  <!-- Facebook Pixel Code -->\
  <script>!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,document,'script','https://connect.facebook.net/en_US/fbevents.js'); fbq('init', '${FB_PIXEL_ID}'); fbq('track','PageView');</script>\
  <noscript><img height=\"1\" width=\"1\" style=\"display:none\" src=\"https://www.facebook.com/tr?id=${FB_PIXEL_ID}&ev=PageView&noscript=1\"/></noscript>\
  <!-- End Facebook Pixel Code -->" src/components/Layout.jsx

# 2) Injection du LinkedIn Insight
sed -i "/<Helmet>/a \
  <!-- LinkedIn Insight Tag -->\
  <script type=\"text/javascript\">_linkedin_partner_id=\"${LI_PARTNER_ID}\";window._linkedin_data_partner_ids=window._linkedin_data_partner_ids||[];window._linkedin_data_partner_ids.push(_linkedin_partner_id);(function(){var s=document.getElementsByTagName(\"script\")[0];var b=document.createElement(\"script\");b.type=\"text/javascript\";b.async=!0;b.src=\"https://snap.licdn.com/li.lms-analytics/insight.min.js\";s.parentNode.insertBefore(b,s)})();</script>\
  <noscript><img height=\"1\" width=\"1\" style=\"display:none\" alt=\"\" src=\"https://px.ads.linkedin.com/collect/?pid=${LI_PARTNER_ID}&fmt=gif\"/></noscript>\
  <!-- End LinkedIn Insight Tag -->" src/components/Layout.jsx

# 3) Track Lead event on form submission
sed -i "/toast.success('Message envoyé !')/a \
      if(window.fbq) fbq('track','Lead');\
      _linkedin_data_partner_ids && _linkedin_data_partner_ids.forEach(pid => window.lintrk('track',{ conversion_id: pid, event: 'formSubmission' }));" src/pages/Contact.jsx

echo "✅ Tracking & Ads ready !  
→ Les placeholders sont injectés :  
   • FB_PIXEL_ID = $FB_PIXEL_ID  
   • LI_PARTNER_ID = $LI_PARTNER_ID  

Tu peux maintenant :  
1. Tester la landing (même sans pixels)  
2. Quand tu récupères enfin tes vrais IDs, ouvre ton `.env` et remplace `YOUR_FB_PIXEL_ID` / `YOUR_LI_PARTNER_ID`  
3. Relance le script ou redéploie — tout se mettra à jour automatiquement 🚀"
