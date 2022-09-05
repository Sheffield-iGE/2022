from time import sleep, time
from drivers import * 

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
    display.text("light: " + str(readLight(), 2) + "%", 5, 5, 1)
    display.text("temp : " + str(round(readTemp(), 1)) + "C", 5, 14, 1)
    display.show()
    sleep(0.3)
    
#     esum = 0
#     target_temp = 37
#     p = 10
#     i = 0.1
#     error = target_temp - readTemp()
#     esum += error
#     heatingPower(p * error + i * esum)
    
    if readTemp() < 30:
        heatingPower(100)
        print("ON")
    else:
        heatingPower(0)
        print("OFF")
    if readLight() < 50:
        speed = adcpump.read_u16()
        pumpPower(speed/65535*100)
        print(adcpump.read_u16())
    sleep(0.1) 