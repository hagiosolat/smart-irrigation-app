import 'package:flutter/material.dart';
import 'package:irrigation1/src/screens/settings_screen.dart';
import 'package:irrigation1/src/screens/weather_screen.dart';

class Routes {

  static final mainRoute = <String, WidgetBuilder>{
    '/home': (context) => WeatherScreen(),
    '/settings': (context) => SettingsScreen(),
  };
}
