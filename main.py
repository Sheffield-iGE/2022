from time import sleep
import combined, ds18x20, onewire, asyncio

while True:
#servo motor
    servomove(-100) 
    sleep(5)
    servomove(50)
    sleep(3)
    servomove(100)
    sleep(5)
    servomove(50)
#heating controller
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