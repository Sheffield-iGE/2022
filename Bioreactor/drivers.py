from machine import Pin, PWM, ADC, I2C
import onewire
import ds18x20
import ssd1306
import math

# servo motor
pwmservo = PWM(Pin(1))
pwmservo.freq(50)
# 1ms = round(65535/20)
# 2ms = round(65535/10)
# 1.5ms = round(65535*0.075)


def servomove(power):
    pwmservo.duty_u16(int((power/100)*1638.375+4915.125))


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


# heating coil
pwmheat = 4
cwPinheat = 3
acwPinheat = 2


def heatingPower(power):
    driveHBridge(power, 1, pwmheat, cwPinheat, acwPinheat)


# pump , max speed = 60mL/min
adcpump = ADC(Pin(27))
pwmpump = 16
cwPinpump = 14
acwPinpump = 15


def pumpPower(power):
    driveHBridge(power, 1, pwmpump, cwPinpump, acwPinpump)


# temp sensor
ds_pin = machine.Pin(21)
ds_sensor = ds18x20.DS18X20(onewire.OneWire(ds_pin))
rom = ds_sensor.scan()[0]


def readTemp():
    ds_sensor.convert_temp()
    return ds_sensor.read_temp(rom)


# phototransistor
photoPIN = 26


def readOD():
    photoRes = ADC(Pin(photoPIN))
    light = photoRes.read_u16()
    light = round(light/65535*100, 2)
    od = -math.log10((100-light)/100)
    return od


# oled display
i2c = I2C(0, sda=Pin(12), scl=Pin(9))
display = ssd1306.SSD1306_I2C(128, 32, i2c)
