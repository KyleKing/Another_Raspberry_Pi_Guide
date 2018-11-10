tput setaf 6; echo "
Airplay shairport-sync installer for Raspberry Pi
"
if [[ $EUID -ne 0 ]]; then
    tput setaf 3; echo "This script needs to be run as root:
    sudo bash Airplay-Shairport-Sync.sh
    "
    exit 1
fi

apt-get update

apt-get install build-essential git -y
apt-get install autoconf automake libtool libdaemon-dev libasound2-dev libpopt-dev libconfig-dev -y
apt-get install avahi-daemon libavahi-client-dev -y
apt-get install libssl-dev -y
apt-get install libsoxr-dev -y

git clone https://github.com/mikebrady/shairport-sync.git
cd shairport-sync
autoreconf -i -f
./configure --sysconfdir=/etc --with-alsa --with-avahi --with-ssl=openssl --with-metadata --with-soxr --with-systemd

make

getent group shairport-sync &>/dev/null || groupadd -r shairport-sync >/dev/null
getent passwd shairport-sync &> /dev/null || useradd -r -M -g shairport-sync -s /usr/bin/nologin -G audio shairport-sync >/dev/null

make install
