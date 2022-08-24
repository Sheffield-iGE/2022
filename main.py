from time import sleep
import combined

while True:
    combined.servomove(-100) 
    sleep(5)
    combined.servomove(50)
    sleep(3)
    combined.servomove(100)
    sleep(5)
    combined.servomove(50)
    for rom in combined.roms:
        combined.display.fill(0)
        combined.display.text("light: " + str(combined.readLight(combined.photoPIN)) + "%", 5, 5, 1)
        combined.display.text("temp : " + str(round(combined.ds_sensor.read_temp(rom), 1)) + "C", 5, 14, 1)
        combined.display.show()
        sleep(0.3)
    if combined.ds_sensor.read_temp(rom) < 38:
        combined.motorMoveheat(100,1,combined.pwmheat,combined.cwPinheat,combined.acwPinheat)
        print("ON")
    else:
        combined.motorMoveheat(0,0,combined.pwmheat,combined.cwPinheat,combined.acwPinheat)
        print("OFF")
    if combined.readLight(combined.photoPIN) > 50:
        speed = combined.adcpump.read_u16()
        combined.motorMovepump(speed/65535*100, 1, combined.pwmpump, combined.cwPinpump, combined.acwPinpump)
        print(combined.adcpump.read_u16())