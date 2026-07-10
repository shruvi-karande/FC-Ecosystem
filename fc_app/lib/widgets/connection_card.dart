import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:provider/provider.dart';
import '../providers/drone_provider.dart';
class ConnectionCard extends StatefulWidget {
  const ConnectionCard({super.key});

  @override
  State<ConnectionCard> createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard> {
  final ApiService apiService = ApiService();


bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final drone = context.watch<DroneProvider>();
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.usb),
                SizedBox(width: 10),
                Text(
                  "Connection",
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
              children:  [
                Text("Status"),
                Chip(
  backgroundColor:
      drone.isConnected ? Colors.green : Colors.red,
  label: Text(
    drone.isConnected ? "Connected" : "Disconnected",
    style: const TextStyle(color: Colors.white),
  ),
),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: drone.isConnected
    ? null
    : () async {
        setState(() {
          isLoading = true;
        });

        bool success = await apiService.connect();
        

        if (success) {
  context.read<DroneProvider>().setConnection(true);
}

setState(() {
  isLoading = false;
});
        if (!success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to connect"),
            ),
          );
        }
      },
                child: isLoading
    ? const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
        ),
      )
    : const Text("Connect"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}