import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:hifidelity/screens/dashboard/dashboard_screen.dart';
import 'package:hifidelity/screens/landing/landing_screen.dart';
import 'package:hifidelity/screens/register/register_screen.dart';
import 'package:hifidelity/screens/settings/settings_screen.dart';
import 'package:hifidelity/services/localization/localization_service.dart';

class AppScreen extends StatefulWidget {
  @override
  State createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  GlobalKey<RegisterScreenState> registerScreenKey = GlobalKey();
  final localizationService = LocalizationService();

  @override
  void initState() {
    localizationService.languageCode = 'en-US';
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  void onInheritedWidgetValueChanged() {
    setState(() {});
  }

  Widget scaffold(Widget child) {
    return AppInheritedWidget(
      localization: localizationService,
      valueChanged: onInheritedWidgetValueChanged,
      child: child,
    );
  }

  @override
  Widget build(BuildContext cxt) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (cxt) => scaffold(LandingScreen()),
        'register': (cxt) => scaffold(RegisterScreen(key: registerScreenKey)),
        'dashboard': (cxt) => scaffold(DashboardScreen()),
        'settings': (cxt) => scaffold(SettingsScreen()),
      },
    );
  }
}