from pymavlink import mavutil
import time

print("Connecting to SITL...")

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

print("Connected!")


mode = 'GUIDED'

if mode not in master.mode_mapping():
    print("GUIDED mode not supported")
    exit()

mode_id = master.mode_mapping()[mode]

master.mav.set_mode_send(
    master.target_system,
    mavutil.mavlink.MAV_MODE_FLAG_CUSTOM_MODE_ENABLED,
    mode_id
)

print("Changing to GUIDED mode...")
time.sleep(2)

print("Arming...")

master.arducopter_arm()

master.motors_armed_wait()

print("Drone Armed!")