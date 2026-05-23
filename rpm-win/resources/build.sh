#!/bin/sh

# ── Build VR application ────────────────────────────────────────────
set -e
workdir=$(pwd)
echo "$workdir"

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
# FIXME: Actually do this

# ── Peasants (Windows) ──────────────────────────────────────────────
# This is a different spec file! (i.e. a PyInstaller spec file)
cd launcher
rm ./BeatSketch
cp ../vr/BeatSketch.exe .
wine python -m PyInstaller BeatSketch.spec
ls dist
cd ..

# ── Finalization ────────────────────────────────────────────────────
# Collect bundles in one folder (for release creation)
# cp ~/rpmbuild/RPMS/x86_64/* $workdir
cp ./beatsketch.tar.gz $workdir
cp ./launcher/dist/BeatSketch.exe $workdir
