from machine import Pin, I2C
import ssd1306
i2c = I2C(0, sda=Pin(12), scl=Pin(9))
display = ssd1306.SSD1306_I2C(128, 32, i2c)
#display.invert(1)
# display.text('rEvolver', 5, 5, 1)
# display.text('Vivo La', 5, 14, 1)
# display.text('Evolution', 5, 22, 1)
# display.show()

#temperature sensor
# import machine, onewire, ds18x20
# from machine import Pin, I2C
# from time import sleep
# from ssd1306 import SSD1306_I2C

# i2c=I2C(0,sda=Pin(12), scl=Pin(9), freq=400000)
# display = SSD1306_I2C(128, 32, i2c)

# ds_pin = machine.Pin(22)
 
# ds_sensor = ds18x20.DS18X20(onewire.OneWire(ds_pin))
 
# roms = ds_sensor.scan()
 
# print('Found DS devices')
# print('Temperature (°C)')
 
# while True:
 
#   ds_sensor.convert_temp()
 
#   sleep(1)
 
#   for rom in roms:
 
#     print(ds_sensor.read_temp(rom))
#     display.fill(0)
#     display.text("Temperature (C)", 5, 5, 1)
#     display.text(str(ds_sensor.read_temp(rom)), 5, 14, 1)
#     display.show()
 
#   sleep(3)

photoPIN = 26
def readLight(photoGP):
    photoRes = ADC(Pin(26))
    light = photoRes.read_u16()
    light = round(light/65535*100)
    return 100-light

while True: 
    display.fill(0)
    display.text("light: " + str(readLight(photoPIN)) + "%", 5, 5, 1)
    display.show()
    sleep(0.3)

