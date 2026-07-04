from pymavlink import mavutil
import time

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

mode = master.mode_mapping()["GUIDED"]

master.mav.set_mode_send(
    master.target_system,
    mavutil.mavlink.MAV_MODE_FLAG_CUSTOM_MODE_ENABLED,
    mode
)

time.sleep(2)

master.arducopter_arm()
master.motors_armed_wait()

print("Taking off...")

master.mav.command_long_send(
    master.target_system,
    master.target_component,
    mavutil.mavlink.MAV_CMD_NAV_TAKEOFF,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    10      # altitude in metres
)

print("Takeoff command sent!")