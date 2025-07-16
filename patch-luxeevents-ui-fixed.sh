# Recreate a minimal, clean bash script without embedded Python data structures or errors

script = """#!/bin/bash

echo '▶ Inject import SoundController into HeroSection.jsx'
sed -i '1,/^export default/ s/^/import SoundController from ".\\/SoundController";\\n/' src/components/HeroSection.jsx
echo

echo '▶ Inject <SoundController /> in JSX section'
sed -i '/<section /a\\  <SoundController />' src/components/HeroSection.jsx
echo

echo '▶ Inject import NextSection in HomePage.jsx'
sed -i '1,/HeroSection/ s|import HeroSection.*|import HeroSection from "@/components/HeroSection";\\nimport NextSection from "@/components/NextSection";|' src/pages/HomePage.jsx
echo

echo '▶ Inject <NextSection /> after <HeroSection />'
sed -i '/<HeroSection \\/>/a\\      <NextSection />' src/pages/HomePage.jsx
echo

echo '▶ Add plugins: [] to tailwind.config.js'
sed -i '/theme: {/,/},/ s/},/},\\n  plugins: [],/' tailwind.config.js
echo
"""

# Save to a new corrected script file
fixed_script_path = Path("/mnt/data/patch-luxeevents-ui-fixed.sh")
fixed_script_path.write_text(script)
fixed_script_path.chmod(0o755)

fixed_script_path.name
