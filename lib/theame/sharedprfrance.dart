import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference extends ChangeNotifier {
  DarkThemePreference() {
    loadValuesFromSharedPreferences();
    startTimerToUpdateTheme();
  }
  String weatherDescription = '';
  double temperature = 0.0;
  int? time;
  String country = '';
  double windspeed = 0;
  double humidity = 0;
  double chanceOfRain = 10;
  String location = '';
  double? latitude;
  double? longitude;
  Timer? timer;
  double? tempmin;
  double? tempmax;
  double? feelslike;
  void startTimerToUpdateTheme() {
    const duration = Duration(seconds: 5); // Adjust the duration as needed
    timer = Timer.periodic(duration, (Timer timer) {
      updateThemeBasedOnTime();
      notifyListeners();
    });
  }

  bool light = true;
  void updateThemeBasedOnTime() {
    final currentTime = DateTime.now();

    if ((currentTime.hour >= 6 && currentTime.minute >= 00 || light == true)) {
      //  currentTheme = ThemeData.dark();
      mytheme(true);
    }
    if ((currentTime.hour >= 18 && currentTime.minute >= 40 ||
        light == false)) {
      // currentTheme = ThemeData.light();
      mytheme(false);
    }

    notifyListeners();
  }

  void mytheme(bool color) {
    light = color;
    notifyListeners();
  }

  Future<void> loadValuesFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    temperature = prefs.getDouble('temperature') ?? 0;
    humidity = prefs.getDouble('humidity') ?? 0.0;
    windspeed = prefs.getDouble('wind') ?? 0;
    location = prefs.getString('location') ?? '';
    weatherDescription = prefs.getString('weather') ?? '';
    tempmin = prefs.getDouble('tempmin') ?? 0;
    tempmax = prefs.getDouble('tempmax') ?? 0;
    feelslike = prefs.getDouble('feelslike') ?? 0;

    notifyListeners();
  }
}
