from pymavlink import mavutil

print("Connecting to SITL...")

# Connect to the drone
master = mavutil.mavlink_connection("udp:0.0.0.0:14550")

print("Waiting for heartbeat...")
master.wait_heartbeat()

print("Connected!")

# Receive a GLOBAL_POSITION_INT message
msg = master.recv_match(type="GLOBAL_POSITION_INT", blocking=True)

# Print altitude information
print("\nAltitude Information")
print("--------------------")
print("Relative Altitude :", msg.relative_alt / 1000, "m")
print("Absolute Altitude :", msg.alt / 1000, "m")