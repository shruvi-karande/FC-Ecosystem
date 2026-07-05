# read current flight mode

from pymavlink import mavutil

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

print("Current Flight Mode:", master.flightmode)