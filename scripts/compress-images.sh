#!/usr/bin/env bash
npx imagemin 'public/media/*.{jpg,png}' --plugin=pngquant --plugin=mozjpeg --out-dir=public/media
