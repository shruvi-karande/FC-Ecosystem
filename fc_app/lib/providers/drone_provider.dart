import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DroneProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool isConnected = false;
  bool isArmed = false;

  String mode = "Unknown";

  double latitude = 0.0;
  double longitude = 0.0;

  double relativeAltitude = 0.0;
  double absoluteAltitude = 0.0;

  double batteryPercentage = 0.0;
  double batteryVoltage = 0.0;

  double roll = 0.0;
double pitch = 0.0;
double yaw = 0.0;

  void setConnection(bool value) {
  isConnected = value;

  if (isConnected) {
    refreshStatus();
  }

  notifyListeners();
}

  Future<void> refreshStatus() async {

  final data = await _api.getStatus();

  if (data == null) {
    isConnected = false;
    isArmed = false;
    notifyListeners();
    return;
  }


  isConnected = data["connected"];
  final armed = data["armed"];

if (armed is bool) {
  isArmed = armed;
} else if (armed is num) {
  isArmed = armed != 0;
}
  mode = data["mode"];

  latitude = (data["latitude"] as num).toDouble();
  longitude = (data["longitude"] as num).toDouble();

  relativeAltitude =
      (data["relative_altitude"] as num).toDouble();

  absoluteAltitude =
      (data["absolute_altitude"] as num).toDouble();

  notifyListeners();
  await refreshBattery();
}
Future<void> refreshBattery() async {

  final data = await _api.getBattery();

  if (data == null) return;

  batteryPercentage =
      (data["battery_remaining"] as num).toDouble();

  batteryVoltage =
      (data["voltage"] as num).toDouble();
      final attitude = await _api.getAttitude();

if (attitude != null) {
  roll = (attitude["roll"] as num).toDouble();
  pitch = (attitude["pitch"] as num).toDouble();
  yaw = (attitude["yaw"] as num).toDouble();
}

  notifyListeners();
}
Future<bool> armDrone() async {
  final success = await _api.arm();

  if (success) {
    await refreshStatus();
  }

  return success;
}
Future<bool> disarmDrone() async {
  final success = await _api.disarm();

  if (success) {
    await refreshStatus();
  }

  return success;
}

}