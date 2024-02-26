#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)" # get current script dir portibly


## check we are sudo
if [[ "${EUID}" -ne 0 ]]; then
	echo "Please run as root (or sudo)."
	exit 1
fi


## ensure version is set
if [ -z "${IN_VERSION}" ]; then
	echo -ne "Please export or set IN_VERSION variable\n"
	exit 1
fi
export IN_VERSION="${IN_VERSION}"


## install deps
apt update 2>/dev/null
apt install build-essential file checkinstall wget -y 2>/dev/null


## run make
cd "${SCRIPT_DIR}"
make


## run makeinstall
checkinstall --install=no \
	--pkgname=libnet-sftp-foreign-perl \
	--pkgversion="5.99+really"${IN_VERSION} \
	--pkgrelease=1 \
	--pkgarch="all" \
	--pkglicense="Perl5" \
	--pkgaltsource="https://metacpan.org/pod/Net::SFTP::Foreign" \
	--maintainer="hosting@ptfs-europe.com" \
	--requires="openssh-client,perl" \
	--strip=no \
	--stripso=no \
	-d2 \
	make install


## tidyup
make clean
git checkout -- .

mkdir -pv ./dist
mv -v ./*.deb ./dist
mv -v ./checkinstall-debug.*.tgz ./dist
