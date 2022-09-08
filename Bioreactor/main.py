from time import sleep, time
from drivers import *
import math

stirringtimer = time()

while True:
    now = time()
    if now-stirringtimer < 5:
        servomove(-100) 
    elif now-stirringtimer < 8:
        servomove(0)
    elif now-stirringtimer < 13:
        servomove(100)
    elif now-stirringtimer < 16:
        servomove(0)
    else:
        stirringtimer = time()
    print(now-stirringtimer)
    display.fill(0)
    display.text("light: " + str(round(readOD(), 2)) + "%", 5, 5, 1)
    display.text("temp : " + str(round(readTemp(), 1)) + "C", 5, 14, 1)
    display.show()
    sleep(0.3)
    
#     esum = 0
#     target_temp = 37
#     p = 1
#     i = 0.01
#     error = target_temp - readTemp()
#     esum += error
#     heatingPower((p * error + i * esum) * 10)
#     print(p + error + i * esum)

    if readTemp() < 36.8:
        heatingPower(100)
    elif readTemp() < 37:
        esum = 0
        target_temp = 37
        p = 1
        i = 0.01
        error = target_temp - readTemp()
        esum += error
        heatingPower((p * error + i * esum) * 10)
        print(p + error + i * esum)
    elif readTemp() > 38:
        heatingPower(0)
    else:
        esum = 0
        target_temp = 37
        p = 1
        i = 0.01
        error = target_temp - readTemp()
        esum += error
        heatingPower((p * error + i * esum) * 100)
        print((p * error + i * esum) * 100)
    print(readOD())
    if readOD() < 50:
        speed = adcpump.read_u16()
        pumpPower(speed/65535*100)
        print(adcpump.read_u16())
    else:
        pumpPower(0)
    sleep(0.1) 