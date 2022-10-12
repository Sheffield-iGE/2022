from machine import ADC, Pin
from time import sleep
#run at 50% power by changing current to 50mA
photoPIN = 26

def readLight(photoGP):
    photoRes = ADC(Pin(26))
    light = photoRes.read_u16()
    light = round(light/65535*100,2)
    return 100-light

while True:
    print("light: " + str(readLight(photoPIN)) +"%")
    sleep(1)