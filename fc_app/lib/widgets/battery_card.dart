import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drone_provider.dart';

class BatteryCard extends StatelessWidget {
  const BatteryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final drone = Provider.of<DroneProvider>(context);

    Color batteryColor;

    if (drone.batteryPercentage > 60) {
      batteryColor = Colors.green;
    } else if (drone.batteryPercentage > 30) {
      batteryColor = Colors.orange;
    } else {
      batteryColor = Colors.red;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const Row(
              children: [
                Icon(Icons.battery_full),
                SizedBox(width: 10),
                Text(
                  "Battery",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: drone.batteryPercentage / 100,
              minHeight: 10,
              borderRadius: BorderRadius.circular(8),
              color: batteryColor,
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Battery"),
                Text("${drone.batteryPercentage.toStringAsFixed(0)}%"),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Voltage"),
                Text("${drone.batteryVoltage.toStringAsFixed(2)} V"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}