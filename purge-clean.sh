#!/bin/bash

echo "📦 Sauvegarde rapide du .git (même si propre)"
cp -r .git .git-backup-before-purge

echo "🚨 Purge SWC binaries + push forcé..."
~/.local/bin/git-filter-repo --path-glob '**/next-swc.linux-*.node' --invert-paths --force

git remote set-url origin git@github.com:adminluxe/luxeevents-frontend.git
git push origin --force --all
