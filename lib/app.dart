import 'package:flutter/material.dart';
import 'package:hifidelity/screens/dashboard/dashboard_screen.dart';
import 'package:hifidelity/screens/landing/landing_screen.dart';
import 'package:hifidelity/screens/settings/settings_screen.dart';

class AppScreen extends StatefulWidget {
  @override
  State createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  Widget build(BuildContext cxt) {
    return MaterialApp(
      // initialRoute: '/home',
      routes: {
        // '/': (cxt) => null,
        '/': (cxt) => LandingScreen(),
        '/dashboard': (cxt) => DashboardScreen(),
        '/settings': (cxt) => SettingsScreen(),
      },
    );
  }
}