set -e
# ── Repos ───────────────────────────────────────────────────────────
echo "
Cloning Repos
"
# Clone repos
git clone https://github.com/BeatSketch/vr
git clone https://github.com/BeatSketch/launcher

# ── Python deps ─────────────────────────────────────────────────────
cd launcher
echo "
Installing pip packages in Wine
"
wine C:/Python/python.exe -m pip install pyinstaller
wine C:/Python/python.exe -m pip install -r requirements.txt

echo "
Installing pip packages in Linux
"
pip install --break-system-packages pyinstaller
pip install --break-system-packages -r requirements.txt

cd ..

# ── LÖVR binaries ───────────────────────────────────────────────────
echo "
Downloading binaries of LOVR to speed up build
"
# TODO: Linux too
cd vr
mkdir LOVR-Windows
cd LOVR-Windows
wget -O windows https://github.com/bjornbytes/lovr/releases/download/v0.18.0/lovr-v0.18.0-win64.zip
unzip windows
rm windows
cd ../
mkdir LOVR-Linux
cd LOVR-Linux
wget -O lovr https://github.com/bjornbytes/lovr/releases/download/v0.18.0/lovr-v0.18.0-x86_64.AppImage
chmod +x lovr
cd /build
