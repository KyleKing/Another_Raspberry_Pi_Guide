# -*- coding: utf-8 -*-

import Adafruit_MAX31855.MAX31855 as MAX31855
import time
import sys

# Change the pins to the correct numbers you configured:
DO__one = 25
CS__one = 20
CLK__one = 19
sensor__one = MAX31855.MAX31855(CLK__one, CS__one, DO__one)
# Note: Pins that didn't work as CLK pins: 16, 21, 6, 5, 13


# Linear calibration
def calib(raw):
    calibrated = raw - 5.5
    return calibrated


# Convert Celsius to Fahrenheit
def c_to_f(celsius):
    fahrenheit = celsius * 9.0 / 5 + 32
    return fahrenheit


# Loop printing measurements every second.
while True:
    temp__one = c_to_f(calib(sensor__one.readTempC()))
    internal__one = c_to_f(calib(sensor__one.readInternalC()))
    CSV = '{0:0.3F}, {1:0.3F}'
    print CSV.format(temp__one, internal__one)

    # Force buffer to close and send data
    sys.stdout.flush()
    # Check temperature every second
    time.sleep(1.0)
