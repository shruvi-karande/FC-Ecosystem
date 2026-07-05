#connect and recieve heartbeat

from pymavlink import mavutil

print("Connecting...")

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")

print("Waiting for heartbeat...")
master.wait_heartbeat()

print("Connected!")