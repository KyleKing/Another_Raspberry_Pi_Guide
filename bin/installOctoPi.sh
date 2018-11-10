tput setaf 6; echo "
OctoPi Installation Script for RPI
"
if [[ $EUID -ne 0 ]]; then
    tput setaf 3; echo "This script needs to be run as root:
    sudo bash installOctoPi.sh
    "
    exit 1
fi

apt-get update
apt-get install git libyaml-dev build-essential -y
apt-get install python-pip python-dev python-setuptools python-virtualenv -y

echo "

# -- Now clone OctoPrint --
cd ~; git clone https://github.com/foosel/OctoPrint.git
cd OctoPrint
virtualenv venv
./venv/bin/pip install pip --upgrade
./venv/bin/python setup.py install
mkdir ~/.octoprint

# Full Guide and other info:
# https://github.com/foosel/OctoPrint/wiki/Setup-on-a-Raspberry-Pi-running-Raspbian

# To Run:
~/OctoPrint/venv/bin/octoprint serve
"
