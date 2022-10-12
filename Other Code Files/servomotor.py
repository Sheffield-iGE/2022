from time import sleep
from machine import Pin, PWM

pwm = PWM(Pin(1))
# 1ms = round(65535/20)
# 2ms = round(65535/10)
# 1.5ms = round(65535*0.075)
pwm.freq(50)

# while True:
#     for position in range(1000,9000,50):
#         pwm.duty_u16(position)
#         sleep(0.01)
#     for position in range(9000,1000,-50):
#         pwm.duty_u16(position)
#         sleep(0.01)

def servomove(power):
    pwm.duty_u16(int((power/100)*1638.375+4915.125))

while True:
#     servomove(-100)
#     sleep(5)
    servomove(0)
#     sleep(3)
#     servomove(100)
#     sleep(5)