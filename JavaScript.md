# JavaScript (Node/Meteor) on the Raspberry Pi

You are viewing the **JavaScript** guide and there are a couple of other guides to check out:

1. [Configuring the Raspberry Pi](https://github.com/KyleKing/Another_Raspberry_Pi_Guide) - (the main README.md)
1. [JavaScript](JavaScript.md) - (NVM and Node)
1. [Peripherals](Peripherals.md) - (Wi-Fi Cmds, Static IP, Arduino)
1. [Electronics](Electronics.md) - (Thermocouple, Pi-Blaster, ADC, MOSFETS, etc.)
1. [BashTools](BashTools.md) - (PushBullet, Scripts, Bash History, Commands Reference)

## Table of Contents

<!-- MarkdownTOC autolink="true" bracket="round" -->

- [Installing Node with NVM](#installing-node-with-nvm)
- [Useful NPM and Node Commands](#useful-npm-and-node-commands)

<!-- /MarkdownTOC -->

## Installing Node with NVM

[See official NVM Install Guide](https://github.com/creationix/nvm#installation). Generally follow these steps:

```sh
# See https address from NVM guide
curl -o- https://raw.githubusercontent.com/creationix/nvm/v<NVM VERSION>/install.sh | bash

# Reload bash profile to circumvent rebooting (https://unix.stackexchange.com/a/30723)
source ~/.bashrc
# Check install
command -v nvm

nvm install node # "node" is an alias for the latest version
```

To start playing around with Node right away, try [this easy, on/off demo](https://github.com/fivdi/onoff) and the [associated guide from Adafruit](https://learn.adafruit.com/node-embedded-development?view=all).

![GIF](https://learn.adafruit.com/system/assets/assets/000/021/906/original/raspberry_pi_demo.gif?1448314329)

## Useful NPM and Node Commands

- `npm i --only=prod` install only packages from dependencies (i.e. skip dev-dependencies/linting tools)
