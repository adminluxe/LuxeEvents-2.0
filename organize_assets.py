#!/usr/bin/env python3
import json
import shutil
from pathlib import Path

def organize_assets(asset_dir='public/assets'):
    """
    Renomme les images et vidéos en image1.jpg, image2.jpg, video1.mp4, etc.
    Crée public/assets/manifest.json avec le mapping.
    """
    asset_path = Path(asset_dir)
    if not asset_path.exists():
        print(f"⛔ Le dossier {asset_dir} n'existe pas.")
        return

    # Cherche les fichiers images/vidéos, ignore ceux débutant par ._
    images = [f for f in asset_path.glob('*') if f.suffix.lower() in ('.jpg','.jpeg','.png','.gif','.webp') and not f.name.startswith('._')]
    videos = [f for f in asset_path.glob('*') if f.suffix.lower() in ('.mp4','.mov','.webm','.ogg','.avi') and not f.name.startswith('._')]

    manifest = {}

    # Renommage des images
    for i, img in enumerate(sorted(images), start=1):
        new_name = f"image{i}{img.suffix}"
        shutil.move(str(img), asset_path / new_name)
        manifest[img.name] = new_name

    # Renommage des vidéos
    for i, vid in enumerate(sorted(videos), start=1):
        new_name = f"video{i}{vid.suffix}"
        shutil.move(str(vid), asset_path / new_name)
        manifest[vid.name] = new_name

    # Écriture du manifest
    with open(asset_path / 'manifest.json', 'w', encoding='utf-8') as f:
        json.dump(manifest, f, ensure_ascii=False, indent=2)

    print("✅ Organisation terminée. Regarde public/assets/manifest.json")
    
if __name__ == "__main__":
    organize_assets()
