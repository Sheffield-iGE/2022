from machine import Pin, PWM
from time import sleep
import onewire, ds18x20, time

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

# main program
while True:
    ds_sensor.convert_temp()
    time.sleep_ms(750)
    for rom in roms:
        print(round(ds_sensor.read_temp(rom), 1))
    time.sleep(0.3)
    if ds_sensor.read_temp(rom) < 32:
        motorMove(100,1,pwmPIN,cwPin,acwPin)
        print("ON")
    else:
        motorMove(0,0,pwmPIN,cwPin,acwPin)
        print("OFF")
#motorMove(100,0,pwmPIN,cwPin,acwPin)