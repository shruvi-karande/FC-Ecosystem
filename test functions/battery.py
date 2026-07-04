from pymavlink import mavutil

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

msg = master.recv_match(type="SYS_STATUS", blocking=True)

print("Battery Voltage:", msg.voltage_battery / 1000, "V")
print("Battery Remaining:", msg.battery_remaining, "%")