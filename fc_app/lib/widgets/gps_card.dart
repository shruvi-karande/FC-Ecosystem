import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drone_provider.dart';

class GpsCard extends StatelessWidget {
  const GpsCard({super.key});

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
                Icon(Icons.location_on),
                SizedBox(width: 10),
                Text(
                  "GPS",
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
                const Text("Latitude"),
                Text(drone.latitude.toStringAsFixed(6)),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Longitude"),
                Text(drone.longitude.toStringAsFixed(6)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}