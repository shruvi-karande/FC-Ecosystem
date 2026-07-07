from flask import Flask
from mavlink_controller import (
    connect,
    arm,
    disarm,
    get_status,
    get_gps,
    get_battery,
    get_attitude,
    get_altitude
)

app = Flask(__name__)


@app.route("/")
def home():
    return {
        "message": "Drone Backend Running"
    }


@app.route("/connect", methods=["POST"])
def connect_drone():

    success = connect()

    if success:
        return {
            "status": "success",
            "message": "Drone Connected"
        }, 200

    return {
        "status": "error",
        "message": "Failed to connect"
    }, 500


@app.route("/arm", methods=["POST"])
def arm_drone():

    success = arm()

    if success:
        return {
            "status": "success",
            "message": "Drone Armed"
        }, 200

    return {
        "status": "error",
        "message": "Failed to arm drone"
    }, 500



@app.route("/disarm", methods=["POST"])
def disarm_drone():

    success = disarm()

    if success:
        return {
            "status": "success",
            "message": "Drone Disarmed"
        }, 200

    return {
        "status": "error",
        "message": "Failed to disarm drone"
    }, 500



@app.route("/status", methods=["GET"])
def status():

    data = get_status()

    if data is None:
        return {
            "status": "error",
            "message": "Drone not connected"
        }, 500

    return data, 200



@app.route("/gps", methods=["GET"])
def gps():

    data = get_gps()

    if data is None:
        return {
            "status": "error",
            "message": "GPS unavailable"
        }, 500

    return data, 200



@app.route("/battery", methods=["GET"])
def battery():

    data = get_battery()

    if data is None:
        return {
            "status": "error",
            "message": "Battery data unavailable"
        }, 500

    return data, 200


@app.route("/attitude", methods=["GET"])
def attitude():

    data = get_attitude()

    if data is None:
        return {
            "status": "error",
            "message": "Attitude data unavailable"
        }, 500

    return data, 200



@app.route("/altitude", methods=["GET"])
def altitude():

    data = get_altitude()

    if data is None:
        return {
            "status": "error",
            "message": "Altitude data unavailable"
        }, 500

    return data, 200


if __name__ == "__main__":
    app.run(debug=True, use_reloader=False)