import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drone_provider.dart';

class AttitudeCard extends StatelessWidget {
  const AttitudeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final drone = Provider.of<DroneProvider>(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const Row(
              children: [
                Icon(Icons.explore),
                SizedBox(width: 10),
                Text(
                  "Attitude",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Roll"),
                Text(drone.roll.toStringAsFixed(2)),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Pitch"),
                Text(drone.pitch.toStringAsFixed(2)),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Yaw"),
                Text(drone.yaw.toStringAsFixed(2)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}