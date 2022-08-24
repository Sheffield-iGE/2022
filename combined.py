from time import sleep
from machine import Pin, PWM, ADC
import onewire, ds18x20, time

#servo motor
pwm = PWM(Pin(1))
pwm.freq(50)
# 1ms = round(65535/20)
# 2ms = round(65535/10)
# 1.5ms = round(65535*0.075)
def servomove(power):
    pwm.duty_u16(int((power/100)*1638.375+4915.125))

#heating coil
pwmPIN=4
cwPin=3 
acwPin=2
def motorMove(speed,direction,speedGP,cwGP,acwGP):
  if speed > 100: speed=100
  if speed < 0: speed=0
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
ds_pin = machine.Pin(21) 
ds_sensor = ds18x20.DS18X20(onewire.OneWire(ds_pin))
roms = ds_sensor.scan()

#phototransistor
photoPIN = 26
def readLight(photoGP):
    photoRes = ADC(Pin(26))
    light = photoRes.read_u16()
    light = round(light/65535*100,2)
    return 100-light

#pump , max speed = 60mL/min
adc = ADC(Pin(27))
pwm = PWM(Pin(16))   
pwmPIN=16
cwPin=14 
acwPin=15
def motorMove(speed,direction,speedGP,cwGP,acwGP):
  if speed > 100: speed=100
  if speed < 0: speed=0
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
