import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../providers/drone_provider.dart';

class MapCard extends StatelessWidget {
  const MapCard({super.key});

  @override
  Widget build(BuildContext context) {
    final drone = Provider.of<DroneProvider>(context);

    final position = LatLng(
      drone.latitude,
      drone.longitude,
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const Row(
              children: [
                Icon(Icons.map),
                SizedBox(width: 10),
                Text(
                  "Drone Map",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 300,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: position,
                  initialZoom: 16,
                ),

                children: [

                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: "com.example.fc_app",
                  ),

                  MarkerLayer(
                    markers: [
                      Marker(
                        point: position,
                        width: 50,
                        height: 50,
                        child: const Icon(
                          Icons.flight,
                          color: Colors.red,
                          size: 35,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}