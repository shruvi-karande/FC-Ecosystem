#read GPS coordinates

from pymavlink import mavutil

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

msg = master.recv_match(type="GLOBAL_POSITION_INT", blocking=True)

print("Latitude :", msg.lat / 1e7)
print("Longitude:", msg.lon / 1e7)