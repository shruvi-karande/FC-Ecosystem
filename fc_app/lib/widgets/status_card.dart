import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drone_provider.dart';
class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

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
                Icon(Icons.flight),
                SizedBox(width: 10),
                Text(
                  "Drone Status",
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
    const Text("Mode"),
    Text(drone.mode),
  ],
),

            const SizedBox(height: 12),

            Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Text("Armed"),
    Text(drone.isArmed ? "Yes" : "No"),
  ],
),

            const SizedBox(height: 12),

             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Relative Altitude"),
                Text("${drone.relativeAltitude.toStringAsFixed(2)} m"),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Absolute Altitude"),
                Text("${drone.absoluteAltitude.toStringAsFixed(2)} m"),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}