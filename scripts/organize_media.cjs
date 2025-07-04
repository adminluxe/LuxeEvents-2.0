// scripts/organize_media.cjs
const fs   = require('fs');
const path = require('path');
const sharp = require('sharp');
const mkdirp = require('mkdirp');

const MEDIA_DIR = path.join(__dirname, '../public/assets/media');
const OUT_IMG   = path.join(MEDIA_DIR, 'images');
const OUT_VID   = path.join(MEDIA_DIR, 'videos');
const OUT_BG    = path.join(MEDIA_DIR, 'background');

[OUT_IMG, OUT_VID, OUT_BG].forEach(d => mkdirp.sync(d));

let imgCount = 1, vidCount = 1;
fs.readdirSync(MEDIA_DIR)
  .filter(f => !fs.lstatSync(path.join(MEDIA_DIR, f)).isDirectory())
  .forEach(file => {
    const ext = path.extname(file).toLowerCase();
    const src = path.join(MEDIA_DIR, file);
    if (['.jpg','.jpeg','.png','.webp'].includes(ext)) {
      const idx = String(imgCount++).padStart(3,'0');
      const base= `img-${idx}`;
      const outJ= path.join(OUT_IMG, base + ext);
      const outW= path.join(OUT_IMG, base + '.webp');
      sharp(src)
        .resize({ width: 1920 })
        .toFile(outJ)
        .catch(() => {})     // skip on error
        .then(() => sharp(src).resize({ width: 1920 }).webp({ quality:80 }).toFile(outW))
        .catch(() => {});
      fs.unlinkSync(src);
    }
    else if (ext === '.mp4') {
      const idx = String(vidCount++).padStart(3,'0');
      const outV = path.join(OUT_VID, `vid-${idx}.mp4`);
      fs.renameSync(src, outV);
    }
    // tout le reste (PDF, GIF, etc.) on l'ignore
  });

console.log('✨ Traitement terminé : images optimisées & vidéos renommées.');
