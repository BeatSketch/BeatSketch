# BeatSketch
A Beat Saber Map maker where you PLAY the map you envison in VR 

If you can't code and still want to help out, [uploading BSOR files](https://polybox.ethz.ch/index.php/s/RbRFRgc7WnmotAg) is an easy way.

## Meta repository
This repository is used for releases, docs and build scripts.
The actual source code is in separate repositories:
- For the VR application: [here](https://github.com/BeatSketch/vr)
- For the launcher: [here](https://github.com/BeatSketch/launcher)

## Packaging notes
Due to lack of time, we currently only have three kinds of Linux packages.
- ArchLinux package (available in the AUR)
- AppImage (you can simply download it, run `chmod +x` on it and you will be able to execute it)
- Semi-built tarball (which is what the PKGBUILD in the AUR uses to build)

There are plans to eventually also provide RPMs and Deb.
