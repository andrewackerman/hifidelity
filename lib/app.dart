import 'package:flutter/material.dart';
import 'package:hifidelity/screens/home/home_screen.dart';
import 'package:hifidelity/screens/landing/landing_screen.dart';

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
        '/home': (cxt) => HomeScreen(),
      },
    );
  }
}