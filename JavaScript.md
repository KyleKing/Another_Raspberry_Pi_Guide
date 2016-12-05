# JavaScript (Node/Meteor) on the Raspberry Pi

You are viewing the **JavaScript** guide and there are tons of other guides to check out:

1. [Configuring the Raspberry Pi (the main README.md)](JavaScript.md)
2. [JavaScript (Running Meteor/Node)](JavaScript.md)
3. [Peripherals (Cameras, Wifi, etc.)](Peripherals.md)
4. [Electronics (Common Circuits, etc.)](Electronics.md)
5. [BashTools (Common Circuits, etc.)](BashTools.md)

<!-- MarkdownTOC depth="6" autolink="true" bracket="round" -->

- [Install and use Node:](#install-and-use-node)
- [How to install Meteor:](#how-to-install-meteor)

<!-- /MarkdownTOC -->

## Install and use Node:

For an easily-packaged script, see [JavaScript/install-node.sh](JavaScript/install-node.sh). This is an abbreviated example:

```
# Increment this to get a newer/older version:
nodeInstallV=v6.0.0
echo "Installing Node $nodeInstallV:"
wget https://nodejs.org/dist/v6.0.0/node-$nodeInstallV-linux-armv7l.tar.gz
tar -xvf node-$nodeInstallV-linux-armv7l.tar.gz
cd node-$nodeInstallV-linux-armv7l
```

To start playing around with Node right away, try [this easy, on/off demo](https://github.com/fivdi/onoff) and the [associated guide from Adafruit](https://learn.adafruit.com/node-embedded-development?view=all).

![GIF](https://learn.adafruit.com/system/assets/assets/000/021/906/original/raspberry_pi_demo.gif?1448314329)

## How to install Meteor:

Run the file, `sudo bash install-meteor.sh` and follow the advice printed. The installation is based on the [universal fork of Meteor](https://github.com/4commerce-technologies-AG/meteor).

To make meteor easier to run, add `"export PATH=$PATH:$HOME/meteor/"` to your `.bashrc file`. For example:

```bash
echo '
# Modified profile for Meteor Universal Installation on $(date)
export PATH=$PATH:$HOME/meteor/
" >> ~/.bashrc'
```
