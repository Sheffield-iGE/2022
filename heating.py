from machine import Pin, PWM
from time import sleep
import ds18b20 

IN1 = Pin(4, Pin.OUT)
IN2 = Pin(3, Pin.OUT)

speed = PWM(Pin(5))
speed.freq(1000)

while True:
        speed.duty_u16(10000)
        IN1.low()  
        IN2.high()
        sleep(5)