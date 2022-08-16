from machine import Pin, PWM
from time import sleep

adc = ADC(Pin(27))
pwm = PWM(Pin(16))   
pwmPIN=16
cwPin=14 
acwPin=15

#current volumetric flowrate = 60mL/min
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

# main program
#motorMove(100,1,pwmPIN,cwPin,acwPin)
#sleep(50)
#motorMove(0,0,pwmPIN,cwPin,acwPin)
#motorMove(100,0,pwmPIN,cwPin,acwPin)

#controlling using potentiometer
while True:
    speed = adc.read_u16()
    motorMove(speed/65535*100, 1, pwmPIN, cwPin, acwPin)
    print(adc.read_u16())
    time.sleep(1)

#stop pumping
#motorMove(0, 1, pwmPIN, cwPin, acwPin)
  
   
