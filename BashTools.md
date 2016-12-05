# Bash Tools

You are viewing the **Bash Tools** guide and there are tons of other guides to check out:

1. [Configuring the Raspberry Pi (the main README.md)](JavaScript.md)
2. [JavaScript (Running Meteor/Node)](JavaScript.md)
3. [Peripherals (Cameras, Wifi, etc.)](Peripherals.md)
4. [Electronics (Common Circuits, etc.)](Electronics.md)
5. [BashTools (Common Circuits, etc.)](BashTools.md)

<!-- MarkdownTOC depth="6" autolink="true" bracket="round" -->

- [FIXME/TODO HOW TO EXECUTABLE SYSTEM WIDE](#fixmetodo-how-to-executable-system-wide)
- [Regular Updates](#regular-updates)
- [Alerting on the End of Long Commands](#alerting-on-the-end-of-long-commands)
- [Mastering Bash History](#mastering-bash-history)

<!-- /MarkdownTOC -->

## FIXME/TODO HOW TO EXECUTABLE SYSTEM WIDE

## Regular Updates

You will want to keep the Raspberry Pi up to date. I made a short script that makes this easy. First it checks to make sure that you are using root permission and then runs the regular apt-get commands. The entire file is included in [bin/pullUpdate](bin/pullUpdate), which I like to store in my `~/bin/` as an executable file.

```bash
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
2. In Pushbullet, go to `Settings`, `Account`, and then click `Create Access Token`
3. Create a file: `pushbullet` somewhere on your computer (for now):

    ```bash
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

4. Test the script, try `bash pushbullet 'IT WORKS!'`
5. If successful, make the script executable from any directory under your user account:

    ```bash
    cp pushbullet ~/bin/pushbullet
    chmod +x ~/bin/pushbullet # or chmod 755 ~/bin/pushbullet
    # now you can call: pushbullet "message text"
    ```

6. **Making a quick reference snippet**. I use the snippet, `; p ` to generate something like: `; pushbullet "Long Script Finished 11:19 AM"`, so I can write: `sleep 2; pushbullet "Long Script Finished 11:20 AM"`. In [Dash](https://kapeli.com/dash), this snippet looks like: `; pushbullet "Long Script Finished @time"` and could easily be added to any snippet manager you use.

## Mastering Bash History

Cherry picked advice from [this guide](https://www.eriwen.com/bash/effective-shorthand/)

1. Edit your .bash_profile or .bashrc by running:

    ```bash
    echo "
    # Modified profile to ignore duplicate history entries on $(date)
    export HISTCONTROL=ignoredups" >> ~/.bashrc
    ```

2. Create an `.inputrc` file, which allows you to auto-complete from history on an arrow key press and a any typed characters:

    ```bash
    cd ~
    touch .inputrc

    # Then copy and past the below text into the nano editor
    nano .inputrc
    ```

    ```bash
    "\eOA": history-search-backward
    "\e[A": history-search-backward
    "\eOB": history-search-forward
    "\e[B": history-search-forward
    "\eOC": forward-char
    "\e[C": forward-char
    "\eOD": backward-char
    "\e[D": backward-char
    ```
