# Bash Tools

You are viewing the **Bash Tools** guide and there are a couple of other guides to check out:

1. [Configuring the Raspberry Pi](https://github.com/KyleKing/Another_Raspberry_Pi_Guide) - (the main README.md)
1. [JavaScript](JavaScript.md) - (NVM and Node)
1. [Peripherals](Peripherals.md) - (Wi-Fi Cmds, Static IP, Arduino)
1. [Electronics](Electronics.md) - (Thermocouple, Pi-Blaster, ADC, MOSFETS, etc.)
1. [BashTools](BashTools.md) - (PushBullet, Scripts, Bash History, Commands Reference)

## Table of Contents

<!-- MarkdownTOC autolink="true" bracket="round" -->

- [System Wide Executable \(~/bin/*\)](#system-wide-executable-bin)
- [Boot On Startup](#boot-on-startup)
- [Regular Updates](#regular-updates)
- [Alerting on the End of Long Commands](#alerting-on-the-end-of-long-commands)
- [Mastering Bash History](#mastering-bash-history)
- [Useful Commands](#useful-commands)

<!-- /MarkdownTOC -->

## System Wide Executable (~/bin/*)

To make a file available everywhere, you need to make it executable `chmod +x  <filename>` and place it in ~/bin/<filename> or another folder part of your path (i.e. append `export PATH=$PATH:$HOME/bin/` to your `~/.bashrc` file)

## Boot On Startup

Edit the rc.local file with `sudo nano /etc/rc.local` [See more about [rc.local on the Raspberry Pi foundation website](https://www.raspberrypi.org/documentation/linux/usage/rc-local.md)]. To start a node application, you could add the snippet:

```sh
# Based on http://stackoverflow.com/a/31113532/3219667
export PATH=/sbin:/usr/sbin:$PATH
cd /home/pi/onoff-shutdown
su pi -c 'node init.es6' &
# For long running tasks, the ampersand creates a separate branch
# Note: 'exit 0' should be the last line of the file
```

## Regular Updates

You will want to keep the Raspberry Pi up to date. I made a short script that makes this easy. First it checks to make sure that you are using root permission and then runs the regular apt-get commands. The entire file is included in [bin/pullUpdate](bin/pullUpdate), which I like to store in my `~/bin/` as an executable file.

```sh
# RPI Update Script
# Written By Kyle King

if [[ $EUID -ne 0 ]]; then
    tput setaf 3; echo "This script needs to be run as root:
    sudo bash update.sh
    "
    exit 1
fi

# Begin by updating the RPI
tput setaf 6; echo "
Searching for out of date packages, installing updates, and cleaning up afterward"
tput setaf 7; echo ""
apt-get update
apt-get upgrade -y # automatic yes to prompts
apt-get dist-upgrade -y
apt-get autoremove && apt-get autoclean
```

## Alerting on the End of Long Commands

This [great guide](http://www.pratermade.com/2014/08/use-pushbullet-to-send-notifications-from-your-pi-to-your-phone/) walks through how to use Pushbullet for bash notifications. I summarized and added my own tweaks below:

1. Make a [Pushbullet](https://www.pushbullet.com/) account and install the app wherever you want to get notifications
1. In Pushbullet, go to `Settings`, `Account`, and then click `Create Access Token`
1. Create a file: `pushbullet` somewhere on your computer (for now):

    ```sh
    #!/bin/bash

    API="<Your Access Token Goes Here>"
    BODY="<Your Raspberry Pi Alert Phrase Here>"
    MSG="$1"

    # Output text as grey
    tput setaf 8; curl -u $API: https://api.pushbullet.com/v2/pushes -d type=note -d title="$MSG" -d body="$BODY"

    # Add some spacing and return to white terminal color
    tput setaf 7; echo '

    '
    ```

1. Test the script, try `bash pushbullet 'IT WORKS!'`
1. If successful, make the script executable from any directory under your user account:

    ```sh
    cp pushbullet ~/bin/pushbullet
    chmod +x ~/bin/pushbullet # or chmod 755 ~/bin/pushbullet
    # now you can call: pushbullet "message text"
    ```

1. **Making a quick reference snippet**. I use the snippet, `; p` to generate something like: `; pushbullet "Long Script Finished 11:19 AM"`, so I can write: `sleep 2; pushbullet "Long Script Finished 11:20 AM"`. In [Dash](https://kapeli.com/dash), this snippet looks like: `; pushbullet "Long Script Finished @time"` and could easily be added to any snippet manager you use.

## Mastering Bash History

Cherry picked advice from [this guide](https://www.eriwen.com/bash/effective-shorthand/)

1. Edit your .bash_profile or .bashrc by running:

    ```sh
    echo "
    # Modified profile to ignore duplicate history entries on $(date)
    export HISTCONTROL=ignoredups" >> ~/.bashrc
    ```

1. Create an `.inputrc` file, which allows you to auto-complete from history on an arrow key press and a any typed characters:

    ```sh
    cd ~
    touch .inputrc

    # Then copy and past the below text into the nano editor
    nano .inputrc
    ```

    ```sh
    "\eOA": history-search-backward
    "\e[A": history-search-backward
    "\eOB": history-search-forward
    "\e[B": history-search-forward
    "\eOC": forward-char
    "\e[C": forward-char
    "\eOD": backward-char
    "\e[D": backward-char
    ```

## Useful Commands

- `sudo raspi-config`
- `ifconfig` - to get wlan0/Wi-Fi IP address of raspberry pi
- `iwconfig` (look for wlan0)
- `lsusb` -> Look for USB device
- `lsumodem`
- `lsmod` -> Look for kernel: 8192cu
- `chmod`

    ```sh
    # Set Read/Write Permissions
    chmod 777 *.sh
    # Make Executable:
    chmod u+x *.sh
    ```

For more commands, see [this Circuit Basic Guide](http://www.circuitbasics.com/useful-raspberry-pi-commands/)
