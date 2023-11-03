import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/theame/sharedprfrance.dart';

import 'model/wheather_model.dart';

class WeatherScreen extends ChangeNotifier {
DarkThemePreference obj = DarkThemePreference();

  String apiKey = dotenv.env['API_KEY'].toString();
  // String cityi = '';
  String weatherDescription = '';
  double temperature = 0.0;
  int? time;
  String country = '';
  double windspeed = 0;
  double humidity = 0;
  double? chanceOfRain = 10;
  String location = '';
  double? latitude;
  double? longitude;
  double? tempmin;
  double? tempmax;
  double? feelsLike;
  Welcome? data;
  late Timer timer;
  bool newday=false;
DateTime currentDay = DateTime.now();
    bool locationRequestedToday=false;

  dayCheck(BuildContext context)  {
  // Check for day change every minute (adjust the duration as needed)
  timer = Timer.periodic(const Duration(days: 1), (timer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? dayStored = prefs.getInt('currentday');
    DateTime newDay = DateTime.now();
    print('newday $newDay');
    print('sharedday $dayStored');
    
    // Extract the year, month, and day from newDay
    int newYear = newDay.year;
    int newMonth = newDay.month;
    int newDayOfMonth = newDay.day;
    int newMinute = newDay.minute;
    // Extract the year, month, and day from dayStored (if it's not null)
    int? storedYear;
    int? storedMonth;
    int? storedDayOfMonth;
    int? storedMinute;
    if (dayStored != null) {
      DateTime storedDate = DateTime.fromMillisecondsSinceEpoch(dayStored);
      storedYear = storedDate.year;
      storedMonth = storedDate.month;
      storedDayOfMonth = storedDate.day;
      storedMinute= storedDate.minute;
    }

    // Check if it's a new day (year, month, and day must match)
    if (newYear != storedYear || newMonth != storedMonth || newDayOfMonth != storedDayOfMonth || newMinute!= storedMinute) {
      currentDay = newDay;
 
      // Save the current day in SharedPreferences
      await prefs.setInt('currentday', newDay.millisecondsSinceEpoch);

      // Call your function here when the day changes
      getCurrentLocation(context);
      locationRequestedToday=true;
      notifyListeners();
      } 
  
  });
}

 
Future<void> getCurrentLocation(BuildContext context) async {
  try {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latitude = position.latitude;
    longitude = position.longitude;
    if (latitude != null && longitude != null) {
      await fetchWeather(latitude: latitude!, longitude: longitude!);
      notifyListeners();
    }
  } catch (e) {
    // Handle exceptions here
    if (e is PlatformException) {
      final errorMessage = e.message;
      if (errorMessage != null && errorMessage.contains('PERMISSION_DENIED')) {
        // User denied location permission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
      } else if (errorMessage != null && errorMessage.contains('SERVICE_DISABLED')) {
        // Location services are disabled
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location services are disabled')),
        );
      } else {
        // Handle other exceptions if needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      // Handle other exceptions if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}


  Future<void> fetchWeather(
      {required double latitude, required double longitude}) async {
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      data = welcomeFromJson(response.body);
        saveValuesToSharedPreferences();
    } else {
      print('Failed to fetch weather data');
    }
  }

  Future<void> apicall({required String name}) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$name,&appid=$apiKey&units=metric'));
    print(response.body);

    if (response.statusCode == 200) {
      data = welcomeFromJson(response.body);
        saveValuesToSharedPreferences();
      
    } else {
      print('Failed to fetch weather data');
    }
  }
  Future<void>saveValuesToSharedPreferences() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
      location = data!.name;
      temperature = data!.main.temp;
      humidity = (data!.main.humidity).toDouble();
      windspeed = data!.wind.speed;
      weatherDescription = data!.weather[0].description;
       tempmin = data!.main.tempMin;
       tempmax = data!.main.tempMax;
        feelsLike = data!.main.feelsLike;
        await prefs.setDouble('temperature',temperature);
        await prefs.setDouble('humidity', humidity);
        await prefs.setDouble('wind', windspeed);
        await prefs.setString('location',location);
        await prefs.setString('weather',weatherDescription);
        await prefs.setDouble('tempmin',tempmin!);
        await prefs.setDouble('tempmin',tempmax!);
        await prefs.setDouble('feelslike', feelsLike!);
        notifyListeners();
  }
}
