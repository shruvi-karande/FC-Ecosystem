from pymavlink import mavutil

master = None


def connect(connection_string="udp:0.0.0.0:14550"):
    """
    Connect to the drone and wait for a heartbeat.

    Returns:
        True  -> Connection successful
        False -> Connection failed
    """

    global master

    if master is not None:
        print("Already connected.")
        return True

    try:
        print(f"Connecting to {connection_string}...")

        master = mavutil.mavlink_connection(connection_string)

        print("Waiting for heartbeat...")
        master.wait_heartbeat(timeout=10)

        print("Heartbeat received!")
        print("Drone connected successfully.")

        return True

    except Exception as e:
        print(f"Connection failed: {e}")
        master = None
        return False


def disconnect():
    """
    Disconnect from the drone.
    """

    global master

    if master is None:
        print("No active connection.")
        return False

    try:
        master.close()
        master = None

        print("Disconnected.")
        return True

    except Exception as e:
        print(f"Disconnect failed: {e}")
        return False


def arm():
    """
    Arm the drone.
    """

    global master

    if master is None:
        print("Drone not connected.")
        return False

    try:
        print("Arming drone...")

        master.arducopter_arm()

        master.motors_armed_wait()

        print("Drone armed successfully.")

        return True

    except Exception as e:
        print(f"Failed to arm: {e}")
        return False


def disarm():
    """
    Disarm the drone.
    """

    global master

    if master is None:
        print("Drone not connected.")
        return False

    try:
        print("Disarming drone...")

        master.arducopter_disarm()

        master.motors_disarmed_wait()

        print("Drone disarmed successfully.")

        return True

    except Exception as e:
        print(f"Failed to disarm: {e}")
        return False



def get_status():
    """
    Get overall drone status.
    """

    global master

    if master is None:
        return None

    try:

        gps = master.recv_match(
            type="GLOBAL_POSITION_INT",
            blocking=True,
            timeout=2
        )

        if gps is None:
            return None

        return {
            "connected": True,
            "armed": master.motors_armed(),
            "mode": master.flightmode,
            "latitude": gps.lat / 1e7,
            "longitude": gps.lon / 1e7,
            "relative_altitude": gps.relative_alt / 1000,
            "absolute_altitude": gps.alt / 1000
        }

    except Exception as e:
        print(f"Status error: {e}")
        return None


def get_gps():
    """
    Get GPS coordinates.
    """

    global master

    if master is None:
        return None

    try:

        gps = master.recv_match(
            type="GLOBAL_POSITION_INT",
            blocking=True,
            timeout=2
        )

        if gps is None:
            return None

        return {
            "latitude": gps.lat / 1e7,
            "longitude": gps.lon / 1e7
        }

    except Exception as e:
        print(f"GPS error: {e}")
        return None


def get_battery():
    """
    Get battery information.
    """

    global master

    if master is None:
        return None

    try:

        battery = master.recv_match(
            type="SYS_STATUS",
            blocking=True,
            timeout=2
        )

        if battery is None:
            return None

        return {
            "battery_remaining": battery.battery_remaining,
            "voltage": battery.voltage_battery / 1000
        }

    except Exception as e:
        print(f"Battery error: {e}")
        return None


def get_attitude():
    """
    Get roll, pitch and yaw.
    """

    global master

    if master is None:
        return None

    try:

        attitude = master.recv_match(
            type="ATTITUDE",
            blocking=True,
            timeout=2
        )

        if attitude is None:
            return None

        return {
            "roll": attitude.roll,
            "pitch": attitude.pitch,
            "yaw": attitude.yaw
        }

    except Exception as e:
        print(f"Attitude error: {e}")
        return None


def get_altitude():
    """
    Get altitude.
    """

    global master

    if master is None:
        return None

    try:

        gps = master.recv_match(
            type="GLOBAL_POSITION_INT",
            blocking=True,
            timeout=2
        )

        if gps is None:
            return None

        return {
            "relative_altitude": gps.relative_alt / 1000,
            "absolute_altitude": gps.alt / 1000
        }

    except Exception as e:
        print(f"Altitude error: {e}")
        return None



if __name__ == "__main__":

    if connect():

        print("\n===== STATUS =====")
        print(get_status())

        print("\n===== GPS =====")
        print(get_gps())

        print("\n===== BATTERY =====")
        print(get_battery())

        print("\n===== ATTITUDE =====")
        print(get_attitude())

        print("\n===== ALTITUDE =====")
        print(get_altitude())

        disarm()

        disconnect()