from machine import Pin, PWM, ADC, I2C
from picozero import Button, Pot
import onewire
import ds18x20
import ssd1306
import math

# Power Button
power_button = Button(2)

# Setting Dials
set_temp = Pot(27)
set_od = Pot(28)


# Read potentiometer as percent
def pot_to_percent(pot):
    return max(0, (pot.voltage - 0.23)) / 3.07


# Servo stirring motor
pwmservo = PWM(Pin(1))
pwmservo.freq(50)


def stirringPower(power):
    pwmservo.duty_u16(int((power/100)*1638.375+4915.125))


# A convenience function for driving both the pump and heating coil
def driveHBridge(speed, direction, speedGP, cwGP, acwGP):
    if speed > 100:
        speed = 100
    if speed < 0:
        speed = 0
    Speed = PWM(Pin(speedGP))
    Speed.freq(50)
    cw = Pin(cwGP, Pin.OUT)
    acw = Pin(acwGP, Pin.OUT)
    Speed.duty_u16(int(speed/100*65536))
    if direction < 0:
        cw.value(0)
        acw.value(1)
    if direction == 0:
        cw.value(0)
        acw.value(0)
    if direction > 0:
        cw.value(1)
        acw.value(0)


# Heating coil pins
pwmheat = 2
cwPinheat = 3
acwPinheat = 4


# Drive the heating coil
def heatingPower(power):
    driveHBridge(power, 1, pwmheat, cwPinheat, acwPinheat)


# Pumping pins
pwmpump = 13
cwPinpump = 14
acwPinpump = 15


# Drive the pump
def pumpPower(power):
    driveHBridge(power, 1, pwmpump, cwPinpump, acwPinpump)


# Temperature scanning and selection
ds_pin = Pin(21)
ds_sensor = ds18x20.DS18X20(onewire.OneWire(ds_pin))
rom = ds_sensor.scan()[0]


# Read temperature in Celsius
def readTemp():
    ds_sensor.convert_temp()
    return ds_sensor.read_temp(rom)


# Phototransistor / OD pin
photoPIN = 26


# Read light intensity
def readintensity():
    photoRes = ADC(Pin(photoPIN))
    intensity = photoRes.read_u16()
    return intensity


# Convert two light readings to an OD
def readOD(i1, i2):
    od = 2.28 * -math.log10(i1/i2)
    return od


# OLED display pins
i2c = I2C(0, sda=Pin(12), scl=Pin(9))
display = ssd1306.SSD1306_I2C(128, 32, i2c)
