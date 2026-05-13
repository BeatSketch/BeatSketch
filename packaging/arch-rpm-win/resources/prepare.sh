#!/bin/sh

set -e
echo "
Setting up extra deps
"
pacman -Sy xorg-server-xvfb --noconfirm

# ── Wine config ─────────────────────────────────────────────────────
# From https://github.com/webcomics/pywine/blob/main/wine-init.sh
# Also thanks to https://askubuntu.com/questions/678277/how-to-install-python3-in-wine
# - Disable menu updates
# - Disable Mono
# - Disable Gecko
echo "
Configuring Wine
"
umask 0
export WINEDLLOVERRIDES="winemenubuilder.exe,mscoree,mshtml="
wine reg add 'HKCU\Software\Wine\DllOverrides' /v winemenubuilder.exe /t REG_SZ /d '' /f
wine reg add 'HKCU\Software\Wine\DllOverrides' /v mscoree /t REG_SZ /d '' /f
wine reg add 'HKCU\Software\Wine\DllOverrides' /v mshtml /t REG_SZ /d '' /f
wineserver -w

# ── Virtual Display ─────────────────────────────────────────────────
echo "
Setting up display for Python Installer
"
Xvfb :0 -screen 0 1024x768x16 &

# Install Windows version of python through wine
echo "
Installing Windows Python in Wine
"
wget https://www.python.org/ftp/python/3.14.4/python-3.14.4-amd64.exe
DISPLAY=:0.0 wine cmd /c 'python-3.14.4-amd64.exe /quiet TargetDir=C:\\Python Include_doc=0 PrependPath=1'
rm python-3.14.4-amd64.exe

# ── Repos ───────────────────────────────────────────────────────────
echo "
Cloning Repos
"
# Clone repos
git clone https://github.com/BeatSketch/vr
git clone https://github.com/BeatSketch/launcher
# TODO: Run the download of the windows binary

# ── Python deps ─────────────────────────────────────────────────────
# Install deps
echo "
Installing deps
"
cd launcher
wine python -m pip install pyinstaller
wine python -m pip install -r requirements.txt

echo "
Installing pip packages in Linux
"
pip install --break-system-packages pyinstaller
pip install --break-system-packages -r requirements.txt

# ── Cleanup ─────────────────────────────────────────────────────────
echo "
Cleaning up
"
pacman -Rs xorg-server-xvfb --noconfirm
