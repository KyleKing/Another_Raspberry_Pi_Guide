# Peripherals

You are viewing the **Peripherals** guide and there are a couple of other guides to check out:

1. [Configuring the Raspberry Pi](https://github.com/KyleKing/Another_Raspberry_Pi_Guide) - (the main README.md)
1. [JavaScript](JavaScript.md) - (NVM and Node)
1. [Peripherals](Peripherals.md) - (Wi-Fi Cmds, Static IP, Arduino)
1. [Electronics](Electronics.md) - (Thermocouple, Pi-Blaster, ADC, MOSFETS, etc.)
1. [BashTools](BashTools.md) - (PushBullet, Scripts, Bash History, Commands Reference)

## Table of Contents

<!-- MarkdownTOC autolink="true" bracket="round" -->

- [Wi-Fi Shortcut Commands](#wi-fi-shortcut-commands)
- [Wi-Fi](#wi-fi)
    - [Ad-Hoc Network](#ad-hoc-network)
    - [Static IP Address Hack from modmypi](#static-ip-address-hack-from-modmypi)
    - [Manually Configure Wi-Fi](#Archive)
    - [Special Case: Prevent Sleep of Edimax EW-7811Un Wi-Fi Adapter](#special-case-prevent-sleep-of-edimax-ew-7811un-wi-fi-adapter)
- [Serial Communication with an Arduino](#serial-communication-with-an-arduino)

<!-- /MarkdownTOC -->

## Wi-Fi Shortcut Commands

- **ifconfig**: Print network connection information
- **iwconfig**: Check network adapter
- `iwlist wlan0 scan`: Prints a list of the currently available wireless networks.
- `iwlist wlan0 scan | grep ESSID`: Use grep along with the name of a field to list only the fields you need (for example to just list the ESSIDs).
- `nmap`: Scans your network and lists connected devices, port number, protocol, state (open or closed) operating system, MAC addresses, and other information.
-`ping`: Tests connectivity between two devices connected on a network. For example, ping 10.0.0.32 will send a packet to the device at IP 10.0.0.32 and wait for a response. It also works with website addresses.
- `wget http://www.website.com/example.txt`: Downloads the file example.txt from the web and saves it to the current directory.

## Wi-Fi

Reference guides for configuring Wi-Fi on the Pi

### Ad-Hoc Network

> See tutorial at [http://slicepi.com/creating-an-ad-hoc-network-for-your-raspberry-pi/](http://slicepi.com/creating-an-ad-hoc-network-for-your-raspberry-pi/)

```sh
# To Switch Between setups:
sudo cp /etc/network/interfaces-Wi-Fi /etc/network/interfaces
# - or -
sudo cp /etc/network/interfaces-adhoc /etc/network/interfaces

# Then Restart
sudo /etc/init.d/networking restart
```

### Static IP Address Hack from modmypi

Append the below snippet with `sudo nano /etc/dhcpcd.conf`:

```sh
interface wlan0

# Change this to the desired static IP
static ip_address=192.168.0.106/24

# Make sure these values are accurate (see guide)
static routers=192.168.0.1
static domain_name_servers=192.168.0.1
```

### Manually Configure Wi-Fi [Archive]

> `raspi-config` now enables basic Wi-Fi configuration, so these manual steps are no longer necessary

Find support [usb Wi-Fi devices here](http://elinux.org/RPi_USB_Wi-Fi_Adapters) or just stick to the [Adafruit USB adapter](https://www.adafruit.com/products/2810?gclid=Cj0KEQiA4JnCBRDQ5be3nKCPhpwBEiQAjwN1biElFqVVBO8mTXXVHUVvKY2mfwei4FzAdYpqZzkz9_4aArBg8P8HAQ).

There are two files to edit, then insert the USB device and restart.

1. Update the credentials. For a typical WPA2 connection (`/etc/wpa_supplicant/wpa_supplicant.conf`). For additional information on static IPs and on non-WPA2 connections, see this [more detailed guide](http://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-Wi-Fi-network/). To see information on ad-hoc networks, see [this guide](http://slicepi.com/creating-an-ad-hoc-network-for-your-raspberry-pi/):

    ```sh
    # sudo nano /etc/wpa_supplicant/wpa_supplicant.conf

    ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
    update_config=1

    network={
            ssid="<SSID>"
            psk="<PASSWORD>"
            proto=RSN
            key_mgmt=WPA-PSK
            pairwise=CCMP
            auth_alg=OPEN
    }
    ```

1. The `/etc/network/interface` file should look something like below (though you likely won't have to make any changes):

    ```sh
    # sudo nano /etc/network/interfaces

    # interfaces(5) file used by ifup(8) and ifdown(8)

    # Please note that this file is written to be used with dhcpcd
    # For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf'

    # Include files from /etc/network/interfaces.d:
    source-directory /etc/network/interfaces.d

    auto wlan0

    auto lo
    iface lo inet loopback

    iface eth0 inet manual

    allow-hotplug wlan0
    iface wlan0 inet dhcp
        wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

    allow-hotplug wlan1
    iface wlan1 inet manual
        wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

    iface default inet dhcp
    ```

Use [speedtest-cli](https://github.com/sivel/speedtest-cli) for testing connection speed. Make sure that you are providing the Raspberry Pi with a good 2A power supply, since most USB Wi-Fi adapters are power hogs and may get clipped and lead to network interruptions otherwise. To troubleshoot use a separate powered USB hub. For the best place to start on Wi-Fi troubleshooting, see [this stackexchange answer](http://raspberrypi.stackexchange.com/a/34952/30942).

### Special Case: Prevent Sleep of Edimax EW-7811Un Wi-Fi Adapter

Edit:

`sudo nano /etc/modprobe.d/8192cu.conf`

Append:

```sh
# Disable power management
options 8192cu rtw_power_mgnt=0 rtw_enusbss=0
```

[Source](https://www.raspberrypi.org/forums/viewtopic.php?t=61665)

## Serial Communication with an Arduino

This is more involved and if you want to see a better guide, check out [Potentiometer](https://github.com/KyleKing/potentiometer) to see how to work with Meteor/Node and an Arduino. To see a more basic example, see [the Team BIKES Stationless BikeShare project](https://github.com/KyleKing/TeamBIKES/tree/master/Coordinator_Raspberry%20Pi)

I haven't tested this, but you should be able to [create aliases to simplify connecting to specific USB devices](http://arduino.stackexchange.com/a/4912). Otherwise the Arduino should have the USB device name with: `/dev/ttyACM<number>`. Run `ls /dev/ttyACM*`. To learn more visit [this Raspberry Pi documentation site](http://raspberry-pi-guide.readthedocs.org/en/latest/system.html)
