# Peripherals

You are viewing the **Peripherals** guide and there are tons of other guides to check out:

1. [Configuring the Raspberry Pi](README.md) - (the main README.md)
2. [JavaScript](JavaScript.md) - (Running Meteor/Node)
3. [Peripherals](Peripherals.md) - (USB Wifi, Serial-Arduino, etc.)
4. [Electronics](Electronics.md) - (Common Circuits, etc.)
5. [BashTools](BashTools.md) - (Common Circuits, etc.)

**Table of Contents**

<!-- MarkdownTOC depth="6" autolink="true" bracket="round" -->

- [Wifi](#wifi)
        - [Ad-Hoc Network](#ad-hoc-network)
        - [Static IP Address Hack from modmypi:](#static-ip-address-hack-from-modmypi)
    - [Special Case: Prevent Sleep of Edimax EW-7811Un Wifi Adapter](#special-case-prevent-sleep-of-edimax-ew-7811un-wifi-adapter)
- [Serial Communication with an Arduino](#serial-communication-with-an-arduino)

<!-- /MarkdownTOC -->

## Wifi

You can't go wrong with supported [usb wifi devices](http://elinux.org/RPi_USB_Wi-Fi_Adapters) or to just stick to the [Adafruit USB adapter](https://www.adafruit.com/products/2810?gclid=Cj0KEQiA4JnCBRDQ5be3nKCPhpwBEiQAjwN1biElFqVVBO8mTXXVHUVvKY2mfwei4FzAdYpqZzkz9_4aArBg8P8HAQ). There are two files to edit, then insert the USB device and restart.

1. Update the credentials. For a typical WPA2 connection (`/etc/wpa_supplicant/wpa_supplicant.conf`). For additional information on static IPs and on non-WPA2 connections, see this [more detailed guide](http://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/). To see information on ad-hoc networks, see [this guide](http://slicepi.com/creating-an-ad-hoc-network-for-your-raspberry-pi/):

    ```bash
    # sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
    # PiSlideshow:

    ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
    update_config=1

    network={
            ssid="Apartment_2.4Ghz"
            psk="suppersnacks"
            proto=RSN
            key_mgmt=WPA-PSK
            pairwise=CCMP
            auth_alg=OPEN
    }
    ```

2. The `/etc/network/interface` file should look something like below (though you likely won't have to make any changes):

    ```bash
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

Use [speedtest-cli](https://github.com/sivel/speedtest-cli) for testing connection speed. Make sure that you are providing the Raspberry Pi with a good 2A power supply, since most USB wifi adapters are power hogs and may get clipped and lead to network interruptions otherwise. To troubleshoot use a separate powered USB hub. For the best place to start on wifi troubleshooting, see [this stackexchange answer](http://raspberrypi.stackexchange.com/a/34952/30942).

#### Ad-Hoc Network

> See tutorial at [http://slicepi.com/creating-an-ad-hoc-network-for-your-raspberry-pi/](http://slicepi.com/creating-an-ad-hoc-network-for-your-raspberry-pi/)

```bash
# To Switch Between setups:
sudo cp /etc/network/interfaces-wifi /etc/network/interfaces
# - or -
sudo cp /etc/network/interfaces-adhoc /etc/network/interfaces

# Then Restart
sudo /etc/init.d/networking restart
```

#### Static IP Address Hack from modmypi:

Append the below snippet with `sudo nano /etc/dhcpcd.conf`:

```bash
interface wlan0

# Change this to the desired static IP
static ip_address=192.168.0.106/24

# Make sure these values are accurate (see guide)
static routers=192.168.0.1
static domain_name_servers=192.168.0.1
```

### Special Case: Prevent Sleep of Edimax EW-7811Un Wifi Adapter

Edit:

`sudo nano /etc/modprobe.d/8192cu.conf`

Append:

```bash
# Disable power management
options 8192cu rtw_power_mgnt=0 rtw_enusbss=0
```

[Source](https://www.raspberrypi.org/forums/viewtopic.php?t=61665)

## Serial Communication with an Arduino

This is more involved and if you want to see a better guide, check out [Potentiometer](https://github.com/KyleKing/potentiometer) to see how to work with Meteor/Node and an Arduino. To see a more basic example, see [the Team BIKES Stationless BikeShare project](https://github.com/KyleKing/TeamBIKES/tree/master/Coordinator_Raspberry%20Pi)

I haven't tested this, but you should be able to [create aliases to simplify connecting to specific USB devices](http://arduino.stackexchange.com/a/4912). Otherwise the Arduino should have the USB device name with: `/dev/ttyACM<number>`. Run `ls /dev/ttyACM*`. To learn more visit [this Raspberry Pi documentation site](http://raspberry-pi-guide.readthedocs.org/en/latest/system.html)

