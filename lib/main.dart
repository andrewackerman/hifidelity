import 'package:flutter/material.dart';
import 'package:hifidelity/app.dart';
import 'package:hifidelity/services/localization/localization.dart';

void main() {
  Localization.setLocale(Locale('en', 'US'));
  runApp(AppScreen());
}