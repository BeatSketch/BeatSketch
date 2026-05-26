#!/bin/sh

# ── Build VR application ────────────────────────────────────────────
set -e
whoami
if [ $# -eq 0 ]; then
	outdir=$(pwd)
else
	if [ -z "$1" ]; then
		outdir=$(pwd)
	else
		outdir=$1
	fi
fi

cd
pwd

export HOME=/root

echo "
Workdir: $outdir
"

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

# ── Create Linux Binary ─────────────────────────────────────────────
echo "
==> Building Linux Application using PyInstaller
"
cd launcher
python -m PyInstaller beatsketch_launcher.spec
tar czf ./beatsketch-binary.tar.gz --directory ./dist/beatsketch .

# ── Peasants (Windows) ──────────────────────────────────────────────
# This is a PyInstaller spec file
echo "
==> Building for Windows using PyInstaller
"
rm ./BeatSketch
rm -rf ./dist/beatsketch
wine C:/Python/python.exe -m PyInstaller beatsketch_launcher.spec

# Copy the VR application into the bundle
cp ../vr/BeatSketch.exe ./dist/beatsketch
zip -9rq BeatSketch.zip ./dist/beatsketch
cd ..

# ── Finalization ────────────────────────────────────────────────────
# Collect bundles in one folder (for release creation)
# cp ~/rpmbuild/RPMS/x86_64/* $workdir
cp ./beatsketch.tar.gz $outdir/beatsketch-linux.tar.gz | true
cp ./launcher/beatsketch-binary.tar.gz $outdir/beatsketch-binary-linux.tar.gz | true
cp ./launcher/BeatSketch.zip $outdir/beatsketch-window.zip | true

ls $outdir
