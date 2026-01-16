#!/bin/bash
set -e

FILE="src/components/HeroSection.jsx"

echo "🎨 Injection overlay luxe..."

sed -i '/className="absolute inset-0 -z-20 bg-center bg-cover"/a\
      <div className="absolute inset-0 -z-10 bg-black/55 backdrop-blur-[1px]" />' "$FILE"

echo "✨ Overlay luxe appliqué"
