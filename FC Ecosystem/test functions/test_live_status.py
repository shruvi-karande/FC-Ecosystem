#continuously display telemetry

from pymavlink import mavutil

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

print("Receiving live telemetry...\n")

while True:
    msg = master.recv_match(type="GLOBAL_POSITION_INT", blocking=True)

    print("----------------------------")
    print("Latitude :", msg.lat / 1e7)
    print("Longitude:", msg.lon / 1e7)
    print("Altitude :", msg.relative_alt / 1000, "m")