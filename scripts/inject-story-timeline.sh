#!/bin/bash

echo "📖 Injection du combo Swiper + Timeline..."

mkdir -p src/components

cp -R ./src/components/* src/components/

echo "✅ Section combinée StorySection injectée. N'oublie pas d'importer dans page.tsx si besoin."
