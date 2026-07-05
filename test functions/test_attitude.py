#read roll, pitch and yaw 

from pymavlink import mavutil

master = mavutil.mavlink_connection("udp:0.0.0.0:14550")
master.wait_heartbeat()

msg = master.recv_match(type="ATTITUDE", blocking=True)

print("Roll :", msg.roll)
print("Pitch:", msg.pitch)
print("Yaw  :", msg.yaw)