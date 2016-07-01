# Node Installation Script for RPI
# Written By Kyle King

tput setaf 6; echo "
PhotoFrame Installation Script for RPI
Only works for Jessie Distribution of Raspbian
"
if [[ $EUID -ne 0 ]]; then
    tput setaf 3; echo "This script needs to be run as root:
    sudo bash install-node.sh
    "
    exit 1
fi

curDir=$(pwd)

# Increment this to get a newer/older version:
nodeInstallV=v6.0.0
armV=armv6l
tput setaf 6; echo "
Installing Node $nodeInstallV. Make sure processor matches $armV:"
cat /proc/cpuinfo | grep "(v"

tput setaf 7; cd $HOME
wget https://nodejs.org/dist/$nodeInstallV/node-$nodeInstallV-linux-$armV.tar.gz
tar -xf node-$nodeInstallV-linux-$armV.tar.gz
cd node-$nodeInstallV-linux-$armV
sudo cp -R * /usr/local/
echo "Done installing Node and NPM, now checking installation:
When running 'which node', you should see: $(which node)
When running 'which npm', you should see: $(which npm)
Installed $(node -v) and $(npm -v)"
cd $curDir
