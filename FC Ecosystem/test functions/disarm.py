from pymavlink import mavutil

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

master.arducopter_disarm()

master.motors_disarmed_wait()

print("Drone Disarmed!")