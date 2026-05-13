Name:           beatsketch
Version:        1.0.0
Release:        1%{?dist}
Summary:        BeatSaber VR Map Maker

License:        GPLv3
URL:            https://github.com/BeatSketch/BeatSketch
Source0:        https://github.com/BeatSketch/BeatSketch/archives/refs/tags/V%{version}.tar.gz

BuildRequires:  python-installer, python-build
Requires:       python, python-yaml, python-pyqt6

%description
A Beat Saber Map maker where you PLAY the map you envison in VR

%prep
# Move downloaded package to expected file format
mv V%{version}.tar.gz %{name}-%{version}.tar.gz
%setup -q

%build
cd "$srcdir/$pkgname-$pkgver"
python -m build --wheel # --no-isolation (may be needed, testing needed)

%install
cd "$srcdir/$pkgname-$pkgver"
python -m installer --destdir="$pkgdir" dist/*.whl

_xdg_desktop_name=io.github.beatsketch.$pkgname

install -Dm 644 "packaging/BeatSketch.desktop" "$pkgdir/usr/share/applications/"

%files
%license LICENSE

%changelog
* Sun May 24 2026 Janis Hutz <development@janishutz.com> - 1.0.0
- Initial Version
