import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:5000";

  Future<bool> connect() async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/connect"),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
  Future<Map<String, dynamic>?> getStatus() async {
  try {
    final response = await http.get(
      Uri.parse("$baseUrl/status"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  } catch (e) {
    return null;
  }
}
Future<Map<String, dynamic>?> getBattery() async {
  try {
    final response = await http.get(
      Uri.parse("$baseUrl/battery"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  } catch (e) {
    return null;
  }
}
Future<Map<String, dynamic>?> getAttitude() async {
  try {
    final response = await http.get(
      Uri.parse("$baseUrl/attitude"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  } catch (e) {
    return null;
  }
}
Future<bool> arm() async {
  try {
    final response = await http.post(
      Uri.parse("$baseUrl/arm"),
    );

    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
Future<bool> disarm() async {
  try {
    final response = await http.post(
      Uri.parse("$baseUrl/disarm"),
    );

    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
}
