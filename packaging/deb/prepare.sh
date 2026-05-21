# TODO: Install packaging tools needed
apt-get update && apt-get install git python-pip

# Clone repos
git clone https://github.com/BeatSketch/vr
git clone https://github.com/BeatSketch/launcher
cd launcher
pip install --break-system-packages pyinstaller
pip install --break-system-packages -r requirements.txt
