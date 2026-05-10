# Build VR application
git clone https://github.com/BeatSketch/vr
cd vr
./build.sh
# TODO: Caching?

cd ..
git clone https://github.com/BeatSketch/launcher
cd launcher

# TODO: For linux packages, consider making separate one for vr application?


cp ./BeatSketch ../../

cd ../stable
# We do not build an arch package because PKGBUILD is a much more sensible approach there
# Build RPM
# TODO: Probably not *this* easy
rpmbuild -bs ./beatsketch.spec

# Build DEB
# TODO: Finish

# Peasants (Windows)
# This is a different spec file! (i.e. a PyInstaller spec file)
wine python -m pip install -r requirements.txt
wine python -m pyinstaller BeatSketch.spec

# TODO: Collect bundles in one folder (for release creation)
