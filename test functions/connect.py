from pymavlink import mavutil

print("Connecting to SITL...")

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")

print("Waiting for heartbeat...")
master.wait_heartbeat()

print("Connected Successfully!")

print("System ID:", master.target_system)
print("Component ID:", master.target_component)
print("Flight Mode:", master.flightmode)