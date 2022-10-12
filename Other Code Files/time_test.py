from time import ticks_us, ticks_diff, sleep
while True:
    start = ticks_us()
    sleep(0.5)
    end = ticks_us()
    usecs = ticks_diff(end,start)
    print(usecs/1000000)