import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hifidelity/screens/dashboard/dashboard_screen.dart';
import 'package:hifidelity/screens/landing/landing_screen.dart';
import 'package:hifidelity/screens/settings/settings_screen.dart';

class AppScreen extends StatefulWidget {
  @override
  State createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  void initState() {
      super.initState();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  @override
  Widget build(BuildContext cxt) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (cxt) => LandingScreen(),
        '/dashboard': (cxt) => DashboardScreen(),
        '/settings': (cxt) => SettingsScreen(),
      },
    );
  }
}