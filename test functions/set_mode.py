from pymavlink import mavutil
import time

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

mode = "GUIDED"

if mode not in master.mode_mapping():
    print("Mode not supported")
    exit()

mode_id = master.mode_mapping()[mode]

master.mav.set_mode_send(
    master.target_system,
    mavutil.mavlink.MAV_MODE_FLAG_CUSTOM_MODE_ENABLED,
    mode_id
)

print(f"Changing mode to {mode}...")
time.sleep(2)

print("Current Mode:", master.flightmode)