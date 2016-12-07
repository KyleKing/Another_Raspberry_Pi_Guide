# Electronics

You are viewing the **Electronics** guide and there are tons of other guides to check out:

1. [Configuring the Raspberry Pi](README.md) - (the main README.md)
2. [JavaScript](JavaScript.md) - (Running Meteor/Node)
3. [Peripherals](Peripherals.md) - (USB Wifi, Serial-Arduino, etc.)
4. [Electronics](Electronics.md) - (Common Circuits, etc.)
5. [BashTools](BashTools.md) - (Common Circuits, etc.)

**Table of Contents**

<!-- MarkdownTOC depth="6" autolink="true" bracket="round" -->

- [Sample Electronic Projects](#sample-electronic-projects)
- [Printable Raspberry Pi Pinout](#printable-raspberry-pi-pinout)
- [Connecting an LED](#connecting-an-led)
- [Thermocouple Sensor \(MAX31855\)](#thermocouple-sensor-max31855)
- [Raspberry Pi PWM with Pi-Blaster](#raspberry-pi-pwm-with-pi-blaster)
- [MOSFETS](#mosfets)
- [Analog to Digital Converter \(ADC\)](#analog-to-digital-converter-adc)

<!-- /MarkdownTOC -->

## Sample Electronic Projects

I have several in-progress Fritzing projects to see in [KyleKing:My-Programming-Sketchbook/Electronics/*](https://github.com/KyleKing/My-Programming-Sketchbook/tree/master/Electronics/)

## Printable Raspberry Pi Pinout

<p align="center">
  <img width="300px" height=auto src="https://www.splitbrain.org/_media/blog/2015-03/gpio.jpg?w=200&tok=ee4ac3">
</p>

The pin diagram in use, [click here to download the printable version](https://github.com/splitbrain/rpibplusleaf)

## Connecting an LED

(Somehow I always forget this) `Long pin === positive (+)`. Connect the long (+ cathode) leg to source and the short leg (- anode) into ground/resistor (a good [resistor is ~1kΩ](http://www.ladyada.net/learn/arduino/lesson3.html), but keep the current under 15mA).

## Thermocouple Sensor (MAX31855)

Download the library for the [Adafruit Python MAX31855](https://github.com/adafruit/Adafruit_Python_MAX31855).To use, run the necessary bash scripts and try the sample Python code in [Electronics/Thermocouple.py](Electronics/Thermocouple.py)

```bash
cd ~
sudo apt-get install build-essential python-dev python-smbus -y
git clone https://github.com/adafruit/Adafruit_Python_MAX31855.git
cd Adafruit_Python_MAX31855
sudo python setup.py install
```

## Raspberry Pi PWM with [Pi-Blaster](https://github.com/sarfata/pi-blaster)

```bash
sudo apt-get install autoconf -y
cd ~
git clone https://github.com/sarfata/pi-blaster.git
cd ~/pi-blaster/
./autogen.sh; ./configure && make
```

To automatically start Pi-Blaster, use: `sudo ~/pi-blaster/pi-blaster`.

To call Pi-Blaster from your node.js app, install the dependency (`npm install pi-blaster.js --save`), then refer to this snippet:

```js
var piblaster = require('pi-blaster.js');
// Available Pins:
// GPIO number   Pin in P1 header
//      4              P1-7
//      17             P1-11
//      18             P1-12
//      21             P1-13
//      22             P1-15
//      23             P1-16
//      24             P1-18
//      25             P1-22

// Example Code
piblaster.setPwm(17, 1.0 ); // 100% brightness
piblaster.setPwm(22, 0.2 ); // 20% brightness
piblaster.setPwm(23, 0 ); // off
```

## MOSFETS

[A brief overview of theory](http://blog.oscarliang.net/how-to-use-mosfet-beginner-tutorial/) and a [basic guide with in process images](http://aruljohn.com/blog/raspberrypi-christmas-lights-rgb-led/). *Note*: it may be useful to use a diode on the drain pin of the MOSFET to protect your circuit, however most common diodes only accept up to 1A.

<p align="center">
  <img width="350px" height=auto src="http://aruljohn.com/blog/pix/ChristmasRGBLEDLights_aruljohn.png">
</p>
<p align="center">Basic MOSFET circuit diagram</p>

## Analog to Digital Converter (ADC)

The [Adafruit Guide](https://learn.adafruit.com/reading-a-analog-in-and-controlling-audio-volume-with-the-raspberry-pi?view=all) and my variation of the example code is available at [Electronics/ADC.py](Electronics/ADC.py)
