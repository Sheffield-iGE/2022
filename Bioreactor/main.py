from time import sleep, time_ns, time, ticks_us, ticks_diff
from drivers import *

stirringtimer = time()
pidtimer = ticks_us()
i1 = readintensity()
esum = 0

while True:
    target_temp = 37
    p = 10
    i = 0.1
    error = target_temp - readTemp()
    pidtime = ticks_diff(ticks_us(),pidtimer)/1000000
    esum += error * pidtime
    print(error, esum)
    pidtimer = ticks_us()
    heatingPower((p * error + i * esum) * 10)
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
        print(readTemp(), p + error + i * esum)
#     print(now-stirringtimer)
    i2 = readintensity()
    display.fill(0)
    display.text("light: " + str(readOD(i1, i2)), 5, 5, 1)
    display.text("temp : " + str(round(readTemp(), 1)) + "C", 5, 14, 1)
    display.show()

    if readOD(i1, i2) > 0.5:
        speed = adcpump.read_u16()
        pumpPower(speed/65535*100)
#         print(adcpump.read_u16())
    else:
        pumpPower(0)
    sleep(0.4) 