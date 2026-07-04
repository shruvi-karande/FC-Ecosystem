from pymavlink import mavutil

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

gps = master.recv_match(type="GLOBAL_POSITION_INT", blocking=True)

print("Mode :", master.flightmode)

print("Armed :", master.motors_armed())

print("Latitude :", gps.lat / 1e7)
print("Longitude:", gps.lon / 1e7)
print("Altitude :", gps.relative_alt / 1000, "m")