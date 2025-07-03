import React from 'react'
import { HelmetProvider, Helmet } from 'react-helmet-async'
import Footer from "./Footer"
import Footer from "./Footer"
import Footer from './Footer'   // si tu as ajouté le footer

export default function Layout({ children }) {
  return (
    <HelmetProvider>
      <Helmet>
<meta property="og:site_name" content="LuxeEvents"/>  <meta property="og:type" content="website"/>  <meta property="og:image" content="/images/og-default.jpg"/>  <script type="application/ld+json">  {    "@context": "https://schema.org",    "@type": "Organization",    "url": "https://www.luxeevents.com",    "logo": "https://www.luxeevents.com/logo.png"  }  </script>
<!-- LinkedIn Insight Tag -->  <script type="text/javascript">_linkedin_partner_id="YOUR_LI_PARTNER_ID";window._linkedin_data_partner_ids=window._linkedin_data_partner_ids||[];window._linkedin_data_partner_ids.push(_linkedin_partner_id);(function(){var s=document.getElementsByTagName("script")[0];var b=document.createElement("script");b.type="text/javascript";b.async=!0;b.src="https://snap.licdn.com/li.lms-analytics/insight.min.js";s.parentNode.insertBefore(b,s)})();</script>  <noscript><img height="1" width="1" style="display:none" alt="" src="https://px.ads.linkedin.com/collect/?pid=YOUR_LI_PARTNER_ID&fmt=gif"/></noscript>  <!-- End LinkedIn Insight Tag -->
<!-- Facebook Pixel Code -->  <script>!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,document,'script','https://connect.facebook.net/en_US/fbevents.js'); fbq('init', 'YOUR_FB_PIXEL_ID'); fbq('track','PageView');</script>  <noscript><img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=YOUR_FB_PIXEL_ID&ev=PageView&noscript=1"/></noscript>  <!-- End Facebook Pixel Code -->
        <meta property="og:type" content="website" />
        <meta property="og:title" content="LuxeEvents — L’Exception sur mesure" />
        <meta property="og:description" content="Vivez l’Exception avec nos expériences exclusives : cocktails, jazz, banquets royaux…" />
        <meta property="og:image" content="/icons/icon-512.png" />
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:title" content="LuxeEvents — L’Exception sur mesure" />
        <meta name="twitter:description" content="Vivez l’Exception avec nos expériences exclusives." />
        <meta name="twitter:image" content="/icons/icon-512.png" />
        <-        <img src={src} alt={`Moment ${i+1}`} className="w-full h-auto" Google tag (gtag.js) -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-XG5982KY2Z"></script>
        <script>
          window.dataLayer = window.dataLayer || [];
          function gtag(){dataLayer.push(arguments);}
          gtag("js", new Date());
          gtag("config", "G-XG5982KY2Z");
        </script>
        {/* Remplace G-XXXXXXXXXX par ton vrai ID */}
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX" />
        <script>{`
          window.dataLayer = window.dataLayer || [];
          function gtag(){dataLayer.push(arguments);}
          gtag('js', new Date());
        gtag("consent","default",{ad_storage:"denied",analytics_storage:"denied"});
          gtag('config', 'G-XXXXXXXXXX');
        `}</script>
        <title>LuxeEvents – L’Exception sur mesure</title>
        <meta
          name="description"
          content="Vivez l’Exception avec nos expériences exclusives : cocktails, jazz, banquets royaux…"
        />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
      </Helmet>
      {children}
      <Footer />
      <Footer />
      <Footer />
    </HelmetProvider>
  )
}
