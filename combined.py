from time import sleep
from machine import Pin, PWM, ADC
import onewire, ds18x20, time

#servo motor
pwmservo = PWM(Pin(1))
pwmservo.freq(50)
# 1ms = round(65535/20)
# 2ms = round(65535/10)
# 1.5ms = round(65535*0.075)
def servomove(power):
    pwmservo.duty_u16(int((power/100)*1638.375+4915.125))

#heating coil
pwmheat=4
cwPinheat=3 
acwPinheat=2
def motorMoveheat(speedheat,directionheat,speedGPheat,cwGPheat,acwGPheat):
  if speedheat > 100: speedheat=100
  if speedheat < 0: speedheat=0
  Speedheat = PWM(Pin(speedGPheat))
  Speedheat.freq(50)
  cwheat = Pin(cwGPheat, Pin.OUT)
  acwheat = Pin(acwGPheat, Pin.OUT)
  Speedheat.duty_u16(int(speedheat/100*65536))
  if directionheat < 0:
      cwheat.value(0)
      acwheat.value(1)
  if directionheat == 0:
      cwheat.value(0)
      acwheat.value(0)
  if directionheat > 0:
      cwheat.value(1)
      acwheat.value(0)
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
adcpump = ADC(Pin(27))
pwmpump = PWM(Pin(16))   
pwmpump=16
cwPinpump=14 
acwPinpump=15
def motorMovepump(speedpump,directionpump,speedGPpump,cwGPpump,acwGPpump):
  if speedpump > 100: speedpump=100
  if speedpump < 0: speedpump=0
  Speedpump = PWM(Pin(speedGPpump))
  Speedpump.freq(50)
  cwpump = Pin(cwGPpump, Pin.OUT)
  acwpump = Pin(acwGPpump, Pin.OUT)
  Speedpump.duty_u16(int(speedpump/100*65536))
  if directionpump < 0:
      cwpump.value(0)
      acwpump.value(1)
  if directionpump == 0:
      cwpump.value(0)
      acwpump.value(0)
  if directionpump > 0:
      cwpump.value(1)
      acwpump.value(0)
