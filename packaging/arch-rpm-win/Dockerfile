FROM archlinux
RUN pacman -S wine wget rpm-tools git

# Install Windows version of python through wine
RUN "wget https://www.python.org/ftp/python/3.14.4/python-3.14.4-amd64.exe \
    && wine 'python-3.14.4-amd64.exe /quiet TargetDir=C:\\Python Include_doc=0 InstallAllUsers=1 PrependPath=1' \
    && rm python-3.14.4-amd64.exe"

RUN wine python -m pip install pyinstaller pyqt6
# TODO: Download everything that is needed already, so it's just a git pull
# Can upgrade the container if the deps need an update -> Much faster build

# Deb packaging will happen in a different container (a deb container)
