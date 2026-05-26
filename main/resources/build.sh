#!/bin/sh

# ── Build VR application ────────────────────────────────────────────
set -e
workdir=$(pwd)
echo "
Workdir: $workdir
Files in this directory:
"
ls -l

cd /build
echo "
==> Building VR application
"
cd vr
# Args: build_linux, build_win, build_mac
git pull
./build.sh true true false
cp ./BeatSketch ../launcher

# ── Complete launcher ───────────────────────────────────────────────
echo "
Updating launcher, downloading models
"
cd ../launcher
git pull

# Download models
cd models
cat models.txt | while read model; do
	wget "https://github.com/BeatSketch/dataset/raw/refs/heads/main/models/${model}"
done

cd /build

# Archive
echo "
Archiving...
"
tar czf ./beatsketch.tar.gz --directory ./launcher .

# ── Create AppImage ─────────────────────────────────────────────────
echo "
==> Creating AppImage
"
cd launcher
python -m PyInstaller beatsketch_launcher.spec
appimage-builder --recipe AppImageBuilder.yml

# ── Peasants (Windows) ──────────────────────────────────────────────
# This is a PyInstaller spec file
cd launcher
rm ./BeatSketch
wine python -m PyInstaller BeatSketch.spec

# Copy the VR application into the bundle
cp ../vr/BeatSketch.exe ./dist/BeatSketch
zip -9r BeatSketch.zip ./dist/beatsketch
cd ..

# ── Finalization ────────────────────────────────────────────────────
# Collect bundles in one folder (for release creation)
# cp ~/rpmbuild/RPMS/x86_64/* $workdir
cp ./beatsketch.tar.gz $workdir
cp ./launcher/dist/BeatSketch.zip $workdir
