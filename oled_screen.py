from machine import Pin, I2C
import ssd1306
i2c = I2C(0, sda=Pin(12), scl=Pin(9))
display = ssd1306.SSD1306_I2C(128, 32, i2c)
#display.invert(1)
display.text('rEvolver', 5, 5, 1)
display.text('Vivo La', 5, 14, 1)
display.text('Evolution', 5, 22, 1)
display.show()
