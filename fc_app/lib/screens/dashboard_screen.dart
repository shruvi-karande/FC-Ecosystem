import 'package:flutter/material.dart';
import '../widgets/connection_card.dart';
import '../widgets/status_card.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../providers/drone_provider.dart';
import '../widgets/battery_card.dart';
import '../widgets/gps_card.dart';
import '../widgets/attitude_card.dart';
import '../widgets/control_card.dart';
import '../widgets/map_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Timer? timer;

  @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<DroneProvider>().refreshStatus();
  });

  timer = Timer.periodic(
    const Duration(seconds: 1),
    (_) {
      context.read<DroneProvider>().refreshStatus();
    },
  );
}
  

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
  title: const Text(
    "FC Dashboard",
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
),
      body:  ListView(
  children: const [
    const Padding(
  padding: EdgeInsets.fromLTRB(18, 12, 18, 8),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Text(
        "Flight Controller",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),

      SizedBox(height: 4),

      Text(
        "Monitor and control your drone in real time",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),

    ],
  ),
),
    SizedBox(height: 10),
    MapCard(),

    ConnectionCard(),
    ControlCard(),

    StatusCard(),
     BatteryCard(),
     GpsCard(),
     AttitudeCard(),
     
     
  ],
),
    );
  }
}