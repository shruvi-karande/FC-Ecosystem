from mavlink_controller import *
import time

connect()

print(get_status())

arm()

time.sleep(2)

takeoff(10)

for i in range(15):
    status = get_status()
    print(f"Altitude: {status['relative_altitude']} m")
    time.sleep(1)

time.sleep(20)

land()

time.sleep(20)

disconnect()