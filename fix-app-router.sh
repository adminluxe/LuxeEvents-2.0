#!/bin/bash

echo "🔧 Correction du double <Router> dans App.jsx..."

sed -i '/BrowserRouter/d' src/App.jsx
sed -i '/as Router/d' src/App.jsx
sed -i '/import .*Routes, Route.*/s/from.*/from '\''react-router-dom'\''/' src/App.jsx
sed -i 's/<Router>//' src/App.jsx
sed -i 's#</Router>##' src/App.jsx

echo "✅ App.jsx corrigé. Tu n’as plus de Router imbriqué."
