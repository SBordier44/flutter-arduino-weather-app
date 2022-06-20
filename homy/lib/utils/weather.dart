import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homy/constants.dart';
import 'package:http/http.dart';

import '../credentials.dart';

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.longitude, required this.latitude});

  final double latitude;
  final double longitude;

  double currentTemperature = 0.0;
  int currentHumidity = 0;
  int currentCondition = 0;
  String currentDescription = '';

  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=fr'));

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'].toDouble();
        currentCondition = currentWeather['weather'][0]['id'];
        currentHumidity = currentWeather['main']['humidity'];
        currentDescription = currentWeather['weather'][0]['description'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
        weatherIcon: kCloudIcon,
        weatherImage: const AssetImage('assets/cloudy.png'),
      );
    } else {
      var now = DateTime.now();
      if (now.hour >= 21 || now.hour <= 8) {
        return WeatherDisplayData(
          weatherImage: const AssetImage('assets/night.png'),
          weatherIcon: kMoonIcon,
        );
      } else {
        return WeatherDisplayData(
          weatherIcon: kSunIcon,
          weatherImage: const AssetImage('assets/cloudy.png'),
        );
      }
    }
  }
}
