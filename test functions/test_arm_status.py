# check if drone is armed

from pymavlink import mavutil

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

if master.motors_armed():
    print("Drone is ARMED")
else:
    print("Drone is DISARMED")