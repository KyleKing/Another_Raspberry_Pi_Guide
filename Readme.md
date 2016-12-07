# My Raspberry Pi Documentation

You are viewing the **Configuring the Raspberry Pi/main** guide and there are tons of other guides to check out:

1. [Configuring the Raspberry Pi](README.md) - (the main README.md)
2. [JavaScript](JavaScript.md) - (Running Meteor/Node)
3. [Peripherals](Peripherals.md) - (USB Wifi, Serial-Arduino, etc.)
4. [Electronics](Electronics.md) - (Common Circuits, etc.)
5. [BashTools](BashTools.md) - (Common Circuits, etc.)

**Table of Contents**

<!-- MarkdownTOC depth="6" autolink="true" bracket="round" -->

- [Starting Fresh](#starting-fresh)
- [\(Option 1\) Booting a Fresh Installation - Easiest/Keyboard Setup](#option-1-booting-a-fresh-installation---easiestkeyboard-setup)
- [\(Option 2\) Booting a Fresh Installation - Headless Connection](#option-2-booting-a-fresh-installation---headless-connection)
- [Configure the Raspberry Pi](#configure-the-raspberry-pi)
- [Troubleshooting Headless Connections](#troubleshooting-headless-connections)
    - [Man in the Middle Warnings](#man-in-the-middle-warnings)
    - [Accessing the Raspberry Pi GUI](#accessing-the-raspberry-pi-gui)
    - [Headless File Transfer \(rsync\)](#headless-file-transfer-rsync)
        - [Moving Files Back from the Raspberry Pi](#moving-files-back-from-the-raspberry-pi)

<!-- /MarkdownTOC -->

## Starting Fresh

How to cleanly install Raspbian Jessie on an 8gb SD card or larger

1. Download `Raspbian-Jessie` - Get the [latest from the Raspberry Pi foundation](https://www.raspberrypi.org/downloads/raspbian/)
2. Format a fresh microSD Card - Using a microSD adapter, erase the microSD card to the `MS-DOS (FAT)` format. On a Mac this can be done through the Disk Utility application
3. Get microSD Card number and eject - On a Mac you can do:

    ```bash
    # Get the microSD disk number and unmount the specified disk (in this case, /dev/disk2)
    diskutil list  # then match up the disk name and disk ID
    diskutil unmountDisk /dev/disk2  # or /disk3 .. etc
    ```

4. Prep your card - Make sure to update the file name and disk ID appropriately from the last step. To check the current status, while writing to the SD card press <kbd>Ctrl</kbd>+<kbd>T</kbd> (on Mac).

    ```bash
    # Navigate to where the .img is downloaded
    cd ~/Downloads
    # Unzip the newly downloaded file
    unzip 2016-05-27-raspbian-jessie.zip
    # Write the unzipped file to your card
    sudo dd bs=1m if=2016-05-27-raspbian-jessie.img of=/dev/rdisk2
    ```

4. Once finished writing, plug the microSD card into the Raspberry Pi and connect the USB Devices/HDMI/Ethernet cord with the micro USB power supply last. You should see the green light blink to confirm the SD card is booting. As the blinks become shorter and less frequent, the Pi is running.

(For additional assistance, see the [Raspberry Pi official guide](http://raspberrypi.stackexchange.com/a/313))

## (Option 1) Booting a Fresh Installation - Easiest/Keyboard Setup

Grab an HDMI display (or HDMI adapter and display), mouse, and keyboard and connect them to the Raspberry Pi. When powered on, you can interact with the Pi as a regular computer.

## (Option 2) Booting a Fresh Installation - Headless Connection

* Connect to a wifi network that allows internet sharing
* Open System Preferences -> Network and make sure there is a profile for an Ethernet connection and a Wifi profile
* The wifi connection should be first and Ethernet second (you can change this by clicking on the cog wheel (bottom of window) > set service order)
* Navigate to the sharing profile and turn on Wifi > Ethernet internet sharing
* Connect the Raspberry Pi, then power it on
* Find the IP address and SSH into the pi (see instructions below)

You will need nmap, which can be [downloaded here](https://nmap.org/download.html#macosx). Look for the `Latest release installer: nmap-7.12.dmg` link (alternatively, you can install nmap with Homebrew `brew install nmap`).

Using nmap, find the raspberry pi's IP address ([Source](http://raspberrypi.stackexchange.com/questions/13936/find-raspberry-pi-address-on-local-network/13937#13937)):

```bash
# sudo nmap -sP 192.168.(<0, 1, or 2>).*
sudo nmap -sP 192.168.0.*

# Now connect to the Pi with the address returned by the previous command
ssh pi@192.168.0.106
# The initial password is `raspberry`, while the user is `pi`
```

(Alternatively, I far and above prefer the free app, [Fling network scanner for iPhone](https://itunes.apple.com/us/app/fing-network-scanner/id430921107?mt=8))

## Configure the Raspberry Pi

The initial password is `raspberry` for user `pi`. Once logged in you will need to run `sudo raspi-config`. Click through the menu options using your arrow keys. You will want to make sure to:

* Expand the file system
* Change password
* Set locale (Internationalisation Options -> Change Locale ->  en_GB.UTF-8 -> then set again as default)
* and any other options you see fit
* Reboot, especially if you changed the filesystem

## Troubleshooting Headless Connections

Since everything works perfectly the first time. Skip this section:

### Man in the Middle Warnings

If having trouble with “man in the middle” warnings, regenerate the SSH key:

```bash
# ssh-keygen -R "<enter hostname>”
ssh-keygen -R 192.168.0.106
```

### Accessing the Raspberry Pi GUI

*VNC Server (Headless GUI) [Source](http://thejackalofjavascript.com/getting-started-raspberry-pi-node-js/)*

You will be prompted to create an 8 character password. Once set, in Safari (Chrome doesn't appear to work) go to `vnc://192.168.0.106:5901` as if a regular URL (or whichever IP address matches your Pi) and enter the password you set in the popup.

```bash
sudo apt-get install tightvncserver
tightvncserver
vncserver :5901

vncserver -kill :5901  # When done
```

### Headless File Transfer (rsync)

rsync is a really useful tool. Lets say you have:

```bash
# on your computer:
dir1/
|__file1.txt
|__file2.txt
|__subdir
    |__file3.txt

# on the pi:
dir2/
|__file4.txt

# to sync, run this from your computer
rsync -azP dir1 pi@192.168.0.106:dir2/

# Then on the pi:
dir2/
|__file4.txt
|__dir1/
    |__file1.txt
    |__file2.txt
    |__subdir
        |__file3.txt
```

That's it. The minimum is to use `rsync -a ./dirName pi@192.168.0.106:~`. **There is one important note**. If you use `dir/` then you will only transfer the subdirectories and files. Just using `dir` keeps the parent folder.

#### Moving Files Back from the Raspberry Pi

```bash
# the pi:
logs/
|__day1.txt
|__day2.txt

# to retrieve the files, run this from your computer
rsync -azP pi@192.168.0.106:~/path/to/logs ./
``

#### Extra rsync Options

Additionally, you may want to:

- ignore folders or files: `rsync -a --exclude=ignoredDir/ ./dirName pi@192.168.0.106:~`
- or delete old files: `rsync -a --delete ./dirName pi@192.168.0.106:~`, but be careful and test this with: `rsync -a --delete --dry-run ./dirName pi@192.168.0.106:~`
- or see progress bars and allow stopped processes to resume: `rsync -azP ./dirName pi@192.168.0.106:~`

If you would like to read more about rsync, read the full [Digital Ocean guide](https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps)

### Backup an Entire SD Card

You will use the dd command line tool to convert a given disk (disk2) into a `.img` file. To reach a more sane file size, use gzip or right click on the file and choose the “compress” menu option on a Mac.

First get the disk number and go to your Desktop or Downloads directory:

```bash
diskutil list
cd ~/Downloads
```

Then use dd, but change the filename to one that makes sense:

```bash
sudo dd if=/dev/rdisk2 of=<fiename>.img bs=1m
```

If you need to delete a .img file, use ```rm``` from the command line, otherwise disk utility seems to think the file space is still in use.
