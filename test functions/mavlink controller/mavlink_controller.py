from pymavlink import mavutil
import time


master = None


def connect(connection_string="udp:0.0.0.0:14550"):
    """
    Connect to the drone and wait for a heartbeat.
    """

    global master

    if master is not None:
        print("Already connected.")
        return master

    print(f"Connecting to {connection_string}...")

    master = mavutil.mavlink_connection(connection_string)

    print("Waiting for heartbeat...")
    master.wait_heartbeat()

    print("Connected Successfully!")
    print(f"System ID: {master.target_system}")
    print(f"Component ID: {master.target_component}")

    return master


def disconnect():
    """
    Close the MAVLink connection.
    """

    global master

    if master is None:
        print("No active connection.")
        return

    master.close()
    master = None

    print("Disconnected.")


def set_mode(mode):
    """
    Change flight mode.
    Example:
        set_mode("GUIDED")
        set_mode("RTL")
        set_mode("LOITER")
    """

    global master

    if master is None:
        raise Exception("Drone not connected!")

    mode = mode.upper()

    if mode not in master.mode_mapping():
        raise Exception(f"{mode} mode not supported.")

    mode_id = master.mode_mapping()[mode]

    master.mav.set_mode_send(
        master.target_system,
        mavutil.mavlink.MAV_MODE_FLAG_CUSTOM_MODE_ENABLED,
        mode_id
    )

    print(f"Changing mode to {mode}...")

    time.sleep(2)

    print("Current Mode:", master.flightmode)


def arm():
    """
    Arm the drone.
    """

    global master

    if master is None:
        raise Exception("Drone not connected!")

    if master.flightmode != "GUIDED":
        set_mode("GUIDED")

    print("Arming Drone...")

    master.arducopter_arm()

    master.motors_armed_wait()

    print("Drone Armed Successfully!")


def disarm():
    """
    Disarm the drone.
    """

    global master

    if master is None:
        raise Exception("Drone not connected!")

    print("Disarming Drone...")

    master.arducopter_disarm()

    master.motors_disarmed_wait()

    print("Drone Disarmed Successfully!")


def takeoff(altitude):
    """
    Take off to the specified altitude.
    """

    global master

    if master is None:
        raise Exception("Drone not connected!")

    if not master.motors_armed():
        arm()

    print(f"Taking off to {altitude} m...")

    master.mav.command_long_send(
        master.target_system,
        master.target_component,
        mavutil.mavlink.MAV_CMD_NAV_TAKEOFF,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        altitude
    )

    print("Takeoff command sent.")


def land():
    """
    Land the drone.
    """

    global master

    if master is None:
        raise Exception("Drone not connected!")

    print("Landing...")

    master.mav.command_long_send(
        master.target_system,
        master.target_component,
        mavutil.mavlink.MAV_CMD_NAV_LAND,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
    )

    print("Land command sent.")


def rtl():
    """
    Return to Launch.
    """

    global master

    if master is None:
        raise Exception("Drone not connected!")

    print("Returning to Launch...")

    master.mav.command_long_send(
        master.target_system,
        master.target_component,
        mavutil.mavlink.MAV_CMD_NAV_RETURN_TO_LAUNCH,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
    )

    print("RTL command sent.")


def get_status():
    """
    Return current drone status as a dictionary.
    """

    global master

    if master is None:
        raise Exception("Drone not connected!")

    gps = master.recv_match(
        type="GLOBAL_POSITION_INT",
        blocking=True
    )

    status = {
        "connected": True,
        "armed": master.motors_armed(),
        "mode": master.flightmode,
        "latitude": gps.lat / 1e7,
        "longitude": gps.lon / 1e7,
        "relative_altitude": gps.relative_alt / 1000,
        "absolute_altitude": gps.alt / 1000
    }

    return status