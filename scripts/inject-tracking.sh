#!/bin/bash

echo "🎯 Injection tracking LuxeEvents..."

sed -i '/<\/head>/i\
<!-- Google Analytics -->\n\
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XG5982KY2Z"></script>\n\
<script>\n\
  window.dataLayer = window.dataLayer || [];\n\
  function gtag(){dataLayer.push(arguments);}\n\
  gtag("js", new Date());\n\
  gtag("config", "G-XG5982KY2Z");\n\
</script>\n\
<!-- Smartlook -->\n\
<script>\n\
  window.smartlook||(function(d) {\n\
    var o=smartlook=function(){ o.api.push(arguments)},h=d.getElementsByTagName("head")[0];\n\
    var c=d.createElement("script");o.api=new Array();c.async=true;c.type="text/javascript";\n\
    c.charset="utf-8";c.src="https://web-sdk.smartlook.com/recorder.js";h.appendChild(c);\n\
  })(document);\n\
  smartlook("init", "2d7c6a5fc7f49e5a8c1e5e7a20904f55fd21e0f727749bec17341cc1b3669562");\n\
</script>' public/index.html

echo "✅ Tracking GA4 + Smartlook injecté avec succès !"
