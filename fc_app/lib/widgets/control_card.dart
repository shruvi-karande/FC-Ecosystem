import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drone_provider.dart';

class ControlCard extends StatefulWidget {
  const ControlCard({super.key});

  @override
  State<ControlCard> createState() => _ControlCardState();
}

class _ControlCardState extends State<ControlCard> {
  bool armLoading = false;
bool disarmLoading = false;
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
                Icon(Icons.gamepad),
                SizedBox(width: 10),
                Text(
                  "Controls",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
  children: [
    Expanded(
      child: ElevatedButton(
        onPressed: (drone.isArmed || armLoading)
    ? null
    : () async {

        setState(() {
          armLoading = true;
        });

        final success = await drone.armDrone();

        if (!mounted) return;

        setState(() {
          armLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? " Drone armed successfully!"
                  : " Failed to arm drone!",
            ),
            backgroundColor:
                success ? Colors.green : Colors.red,
          ),
        );
      },
        child: armLoading
    ? const SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: Colors.white,
        ),
      )
    : Text(
        drone.isArmed ? "ARMED ✓" : "ARM",
      ),
      ),
    ),

    const SizedBox(width: 12),

    Expanded(
      child: ElevatedButton(
        onPressed: (drone.isArmed && !disarmLoading)
    ? () async {

        setState(() {
          disarmLoading = true;
        });

        final success = await drone.disarmDrone();

        if (!mounted) return;

        setState(() {
          disarmLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? " Drone disarmed successfully!"
                  : " Failed to disarm drone!",
            ),
            backgroundColor:
                success ? Colors.green : Colors.red,
          ),
        );
      }
    : null,
        child: disarmLoading
    ? const SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: Colors.white,
        ),
      )
    : const Text("DISARM"),
      ),
    ),
  ],
),
          ],
        ),
      ),
    );
  }
}