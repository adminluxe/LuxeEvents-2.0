import os
import shutil
import hashlib

# Script to organize and dedupe media files
source_dirs = [
    os.path.expanduser("~/assets"),
    os.path.expanduser("~/medias_final")
]
target_base = os.path.expanduser("~/luxeevents-frontend/public/assets")
target_dirs = {
    'images': ['.png', '.jpg', '.jpeg', '.webp'],
    'videos': ['.mp4', '.mov', '.avi']
}

# Collect files
file_hashes = {}
duplicates = []
os.makedirs(target_base, exist_ok=True)
for folder, exts in target_dirs.items():
    os.makedirs(os.path.join(target_base, folder), exist_ok=True)

for src in source_dirs:
    if not os.path.isdir(src):
        continue
    for root, dirs, files in os.walk(src):
        for name in files:
            ext = os.path.splitext(name)[1].lower()
            for folder, exts in target_dirs.items():
                if ext in exts:
                    file_path = os.path.join(root, name)
                    # Compute hash
                    hasher = hashlib.sha256()
                    with open(file_path, 'rb') as f:
                        buf = f.read()
                        hasher.update(buf)
                    h = hasher.hexdigest()
                    if h in file_hashes:
                        duplicates.append(file_path)
                    else:
                        target_path = os.path.join(target_base, folder, name)
                        file_hashes[h] = target_path
                        shutil.copy2(file_path, target_path)
                    break

# Report
import pandas as pd
df = pd.DataFrame({
    'duplicate_files': duplicates
})
import ace_tools as tools; tools.display_dataframe_to_user(name="Duplicate Files", dataframe=df)

print(f"Organized {len(file_hashes)} unique files.")
