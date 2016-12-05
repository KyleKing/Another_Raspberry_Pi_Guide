# Peripherals

You are viewing the **Peripherals** guide and there are tons of other guides to check out:

1. [Configuring the Raspberry Pi (the main README.md)](JavaScript.md)
2. [JavaScript (Running Meteor/Node)](JavaScript.md)
3. [Peripherals (Cameras, Wifi, etc.)](Peripherals.md)
4. [Electronics (Common Circuits, etc.)](Electronics.md)
5. [BashTools (Common Circuits, etc.)](BashTools.md)

<!-- MarkdownTOC depth="6" autolink="true" bracket="round" -->

- [TODO - Wifi](#todo---wifi)
- [TODO An Arduino](#todo-an-arduino)
- [Other Things I Haven't Used Yet](#other-things-i-havent-used-yet)

<!-- /MarkdownTOC -->

## TODO - Wifi

Using the [Realtek Wireless dongle]()

Basically, plug it in and boot the raspberry pi. There shouldn't be any necessary drivers. To connect to a network, either use the UI (easiest) or the command line, both of which are explained in [this Adafruit guide](https://learn.adafruit.com/adafruits-raspberry-pi-lesson-3-network-setup?view=all).Alternatively, these two guides are equally useful:
[Make Tech Easier](https://www.maketecheasier.com/setup-wifi-on-raspberry-pi/) or an [alternative guide](http://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/).

You will need a 2 amp micro USB power supply otherwise you may have a slow or inconsistent connection.

## TODO An Arduino

*I guess this counts as a peripheral?*

How to Connect an Arduino over Serial
Source -> possible to symlink if trouble identifying multiple devices
http://arduino.stackexchange.com/questions/3680/in-linux-how-to-identify-multiple-arduinos-connected-over-usb

The connected arduino should follow this pattern: /dev/ttyACM0 or /dev/ttyACM1 etc.
Search by running $ ls /dev/ttyACM*
Also useful: “Get to know your RPI”
http://raspberry-pi-guide.readthedocs.org/en/latest/system.html

## Other Things I Haven't Used Yet

- [How to Pi Camera](https://github.com/raspberrypilearning/guides/blob/master/camera/README.md)
- [Stream a USB Webcam - sirlagz](http://sirlagz.net/2013/01/07/how-to-stream-a-webcam-from-the-raspberry-pi-part-3/)
- [Stream a USB Webcam - fluent-ffmpeg](https://github.com/fluent-ffmpeg/node-fluent-ffmpeg)
