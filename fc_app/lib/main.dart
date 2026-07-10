import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'providers/drone_provider.dart';
void main() {
  runApp(
  ChangeNotifierProvider(
    create: (_) => DroneProvider(),
    child: const FCApp(),
  ),
);
}

class FCApp extends StatelessWidget {
  const FCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FC App',
      theme: AppTheme.darkTheme,
      home: const DashboardScreen(),
    );
  }
}