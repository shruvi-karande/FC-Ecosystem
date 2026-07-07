from pymavlink import mavutil

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

msg = master.recv_match(type="GLOBAL_POSITION_INT", blocking=True)

print("Relative Altitude:", msg.relative_alt / 1000, "m")
print("Absolute Altitude:", msg.alt / 1000, "m")