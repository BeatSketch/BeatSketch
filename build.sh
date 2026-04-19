#!/bin/sh

# Build for GNU/Linux
zip -9qr BeatSketch.lovr .
cat /usr/bin/lovr BeatSketch.lovr > BeatSketch
chmod +x ./BeatSketch


# Build for the peasants (Windows users)
# TODO: Needs verification (that it works)
if [ -d "./LOVR-Windows/" ]; then
    echo "LOVR-Windows already exists, skipping download"
    cd LOVR-Windows
else
    mkdir LOVR-Windows
    cd LOVR-Windows
    wget https://lovr.org/download/windows
    unzip windows
    rm windows
fi

cp ../BeatSketch.lovr .
cat ./lovr.exe BeatSketch.lovr > BeatSketch.exe
rm BeatSketch.lovr
cp BeatSketch.exe ..
cd ..
rm BeatSketch.lovr

# TODO: Mac Build?
