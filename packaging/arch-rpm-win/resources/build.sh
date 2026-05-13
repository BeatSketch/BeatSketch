# #!/bin/sh

# ── Build VR application ────────────────────────────────────────────
echo "
==> Building VR application
"
cd vr
# Args: build_linux, build_win, build_mac
# TODO: Caching the windows binary
./build.sh true true false
cp ./BeatSketch ../launcher

# ── Build RPM ───────────────────────────────────────────────────────
cd ..
echo "
==> Creating RPM
"
# TODO: tar the files in here, then rename to beatsketch.tar.gz
# Then run rpm build
# TODO: Probably not *this* easy
rpmbuild -bs beatsketch.spec
ls -la

# ── Peasants (Windows) ──────────────────────────────────────────────
# This is a different spec file! (i.e. a PyInstaller spec file)
cd launcher
rm ./BeatSketch
cp ../vr/BeatSketch.exe .
wine python -m PyInstaller BeatSketch.spec

# Collect bundles in one folder (for release creation)
