from time import sleep, time, ticks_us, ticks_diff
from drivers import *

# Establish some global state
stirringtimer = time()
pidtimer = ticks_us()
i1 = readintensity()
esum = 0
on = False

# Code to run when the start / stop button is pressed
def toggle_power():
    global on, i1
    on = not on
    i1 = readintensity()
    stirringPower(0)
    pumpPower(0)


# Trigger the `toggle_power()` function when the button is pressed
power_button.when_pressed = toggle_power

# Loop infinitely
while True:
    # Wait for a moment (200ms)
    sleep(0.2)
    # If the bioreactor is not powered on, skip to the next loop
    if not on:
        continue

    # Set a fixed target temperature (will be user controlled in the future)
    target_temp = 37
    # Establish some PI control parameters
    p = 10
    i = 0.1
    error = target_temp - readTemp()
    # Scale error accumulation by elapsed time
    pidtime = ticks_diff(ticks_us(), pidtimer) / 1000000
    esum += error * pidtime
    pidtimer = ticks_us()
    # Set the heating power according to the PI controller's output
    heatingPower(p * error + i * esum)

    # Get the current time
    now = time()
    # Depending on how much time has passed, set the stirring direction power
    if now - stirringtimer < 5:
        stirringPower(-100)
    elif now - stirringtimer < 8:
        stirringPower(0)
    elif now - stirringtimer < 13:
        stirringPower(100)
    elif now - stirringtimer < 16:
        stirringPower(0)
    else:
        # After getting this far, reset the timer to start over
        stirringtimer = time()

    # Take a new light reading
    i2 = readintensity()

    # Fill the display with OD and temperature readings
    display.fill(0)
    display.text(f"OD: {readOD(i1, i2):.3f}", 5, 5, 1)
    display.text(f"Temp: {readTemp():.1f}C", 5, 14, 1)
    display.show()

    # If the OD is greater than 0.5, dilute the media (will be user controlled)
    if readOD(i1, i2) > 0.5:
        pumpPower(100)
    else:
        pumpPower(0)
