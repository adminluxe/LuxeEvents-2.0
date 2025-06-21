#!/bin/bash
# DESC: Déploie ou exécute automatiquement le script 'fix-all'. Description à compléter.
echo "🧹 Nettoyage & corrections automatiques"

# 1. Supprime les imports react-refresh dans tout src/
find src -type f -name "*.js" -exec sed -i '/react-refresh\/runtime/d' {} \;

# 2. Installe styled-components si absent
npm install styled-components --legacy-peer-deps

# 3. Corrige les extensions dans les imports
#   - LanguageSwitcher.js
sed -i 's|import styled from "styled-components";|import styled from "styled-components";|g' src/components/LanguageSwitcher.js

#   - App.js imports
sed -i 's|import LanguageSwitcher.*|import LanguageSwitcher from "./components/LanguageSwitcher.js";|g' src/App.js
sed -i 's|import Events.*|import Events from "./pages/Events.js";|g' src/App.js
sed -i 's|import .* from .*/i18n.*|import "./i18n.js";|g' src/App.js

#   - index.js fix .js.js → .js
sed -i 's|\.js\.js|.js|g' src/index.js

#   - Events.js imports
sed -i 's|import styled from "styled-components";|import styled from "styled-components";|g' src/pages/Events.js
sed -i 's|import { events, splitEvents } from .*/utils/eventsData.*|import { events, splitEvents } from "../utils/eventsData.js";|g' src/pages/Events.js

echo "✅ Corrections appliquées. Relance vite : npm start"
