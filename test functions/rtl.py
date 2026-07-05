from pymavlink import mavutil

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

master.mav.command_long_send(
    master.target_system,
    master.target_component,
    mavutil.mavlink.MAV_CMD_NAV_RETURN_TO_LAUNCH,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
)

print("Returning to Launch...")