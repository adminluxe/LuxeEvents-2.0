#!/bin/bash

echo "📱 Responsive Enhancer – LuxeEvents"

# 🧩 Injecte scroll-snap et padding pour sections
find ./src/pages ./src/components -type f -name "*.jsx" -exec sed -i '' 's/className="section-wrapper"/className="section-wrapper snap-start px-4 md:px-8"/g' {} +

# ✅ Ajoute media queries dans globals.css
echo "@media (max-width: 768px) {.text-xl {font-size: 1.125rem;} .hero-title {font-size: 2rem;}}" >> ./src/styles/globals.css

echo "✅ Responsive & flow améliorés"
